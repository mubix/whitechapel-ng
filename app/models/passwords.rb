class Passwords < ActiveRecord::Base
	has_many :password_hashes, :class_name => "PasswordHashes", :foreign_key => "password_id"
  validates :cleartext, presence: true, uniqueness: {case_sensitive: true}

	def add_cleartext_one(cleartext)
		password = Passwords.find_or_create_by(cleartext: cleartext)
		cleartext_db = password.save
		if cleartext_db
			puts "Sending #{cleartext} to hash generator"
			PasswordHashes.new.generate_hashes_from_cleartext(cleartext, password.id)
		end
	end
end