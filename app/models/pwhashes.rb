class Pwhashes < ActiveRecord::Base
  belongs_to :password, :class_name => "Passwords", :foreign_key => "password_id"
  belongs_to :status, :class_name => "Statuses", :foreign_key => "status_id"
  belongs_to :type, :class_name => "Types", :foreign_key => "type_id"

  validates :password_hash, presence: true, uniqueness: {case_sensitive: true}
  validates :status_id, presence: true

  include PgSearch
  pg_search_scope :search_hashes, :against => [:password_hash]

  def generate_hashes_from_cleartext(cleartext, passwordID)
    require 'digest/sha1'
    require 'digest/md5'
    require 'rex/text'
    require 'rex/proto/ntlm/crypt'
    puts "Looking up status"
    rex_crypt = Rex::Proto::NTLM::Crypt
    status = Statuses.find_by_name("generated")

    puts "Creating hash of hashes"
    pwhashes = {}

    puts "Generating hashes"

    pwhashes["lm"] = {:pwhash => rex_crypt.lm_hash(cleartext[0..13]).unpack("H*").join}
    pwhashes["ntlm"] = {:pwhash => rex_crypt.ntlm_hash(cleartext).unpack("H*")[0]}
    pwhashes["ntlmv1"] = {:pwhash => rex_crypt.ntlm_response(:ntlm_hash => [rex_crypt.ntlm_hash(cleartext).unpack("H*")[0]].pack("H*"), :challenge => ['1122334455667788'].pack("H*")).unpack("H*")[0] }
    pwhashes["md5"] = {:pwhash => Digest::MD5.hexdigest(cleartext)}
    pwhashes["sha1"] = {:pwhash => Digest::SHA1.hexdigest(cleartext)}
    pwhashes["sha256"] = {:pwhash => Digest::SHA256.hexdigest(cleartext)}
    pwhashes["sha512"] = {:pwhash => Digest::SHA512.hexdigest(cleartext)}
    pwhashes["mysql"] = {:pwhash => "*" + Digest::SHA1.hexdigest(Digest::SHA1.digest(cleartext)).upcase}

    pwhashes.each do |type, pwhash|
      p type
      p pwhash[:pwhash]
      Pwhashes.new(password_hash: pwhash[:pwhash], type_id: Types.find_by_name(type.downcase).id, status_id: status.id, password_id: passwordID).save
    end
  end
end
