class PasswordHashes < ActiveRecord::Base
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
		hashes = {}

		puts "Generating hashes"
		hashes["md5"] = {:pwhash => Digest::MD5.hexdigest(cleartext)}
    hashes["sha1"] = {:pwhash => Digest::SHA1.hexdigest(cleartext)}
    hashes["sha256"] = {:pwhash => Digest::SHA256.hexdigest(cleartext)}
    hashes["sha512"] = {:pwhash => Digest::SHA512.hexdigest(cleartext)}
    hashes["mysql"] = {:pwhash => "*" + Digest::SHA1.hexdigest(Digest::SHA1.digest(cleartext)).upcase}
    
    hashes.each do |type, hash|
    	p type
    	p hash[:pwhash]
    	PasswordHashes.new(password_hash: hash[:pwhash], type_id: Types.find_by_name(type.downcase).id, status_id: status.id, password_id: passwordID).save
    end
	end
end