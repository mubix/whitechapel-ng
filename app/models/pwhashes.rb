class Pwhashes < ActiveRecord::Base
  belongs_to :password, :class_name => "Passwords", :foreign_key => "password_id"
  belongs_to :status, :class_name => "Statuses", :foreign_key => "status_id"
  belongs_to :type, :class_name => "Types", :foreign_key => "type_id"

  validates :password_hash, presence: true, uniqueness: {case_sensitive: true}
  validates :status_id, presence: true

  def generate_hashes_from_cleartext(cleartext, passwordID)
    require 'digest/sha1'
    require 'digest/md5'
    puts "Looking up status"
    status = Statuses.find_by_name("cleartext")

    puts "Creating hash of hashes"
    pwhashes = {}

    puts "Generating hashes"
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
