class PasswordHashes < ActiveRecord::Base
	belongs_to :password, :class_name => "Passwords", :foreign_key => "password_id"
	belongs_to :status, :class_name => "Statuses", :foreign_key => "status_id"
	belongs_to :type, :class_name => "Types", :foreign_key => "type_id"

	validates :password_hash, presence: true, uniqueness: {case_sensitive: true}
	validates :status_id, presence: true

	def generate_hashes_from_cleartext(cleartext, passwordID)
		require 'digest/sha1'
		require 'digest/md5'
		status = Statuses.find_by_name("cleartext")
		md5 = Digest::MD5.hexdigest(cleartext)
    sha1 = Digest::SHA1.hexdigest(cleartext)
    sha256 = Digest::SHA256.hexdigest(cleartext)
    sha512 = Digest::SHA512.hexdigest(cleartext)
    mysql = "*" + Digest::SHA1.hexdigest(Digest::SHA1.digest(cleartext)).upcase(cleartext)
		PasswordHashes.new(password_hash: md5, type_id: Types.find_by_name("MD5").id, status_id: status.id, password_id: passwordID)
	end
end

  			
    
