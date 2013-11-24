class Statuses < ActiveRecord::Base
	has_many :password_hashes, :class_name => "PasswordHashes", :foreign_key => "password_id"
	validates :name, presence: true, uniqueness: {case_sensitive: true}

end
