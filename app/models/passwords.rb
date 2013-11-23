class Passwords < ActiveRecord::Base
	belongs_to :password_hashes
  validates :cleartext, presence: true, uniqueness: {case_sensitive: true}

	def add_cleartext_one(cleartext)
		password = Passwords.new(cleartext: cleartext)
		cleartext_db = password.save
		if cleartext_db
			PasswordHashes.new.generate_hashes_from_cleartext(cleartext, password.id)
		end
	end
end