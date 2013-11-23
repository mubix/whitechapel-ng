class PasswordHashes < ActiveRecord::Base
	belongs_to :password, :class_name => "Passwords", :foreign_key => "password_id"
	belongs_to :status, :class_name => "Statuses", :foreign_key => "status_id"
	belongs_to :type, :class_name => "Types", :foreign_key => "type_id"
end
