class Passwords < ActiveRecord::Base
	has_many :password_hashes, :class_name => "Pwhashes", :foreign_key => "password_id"
  validates :cleartext, presence: true, uniqueness: {case_sensitive: true}
  validates :source, presence: true

  
  include PgSearch
  pg_search_scope :search_cleartext, :against => [:cleartext]
	
	def self.add_cleartext_one(cleartext, source)
		cleartext = cleartext.gsub("\n","")
		password = Passwords.find_or_create_by(cleartext: cleartext, source: source)
		cleartext_db = password.save
		if cleartext_db
			Pwhashes.delay.generate_hashes_from_cleartext(cleartext, password.id)
		end
	end

	def self.add_cleartext_list(file_path, source)
		file = File.open(file_path, 'r')
		file.each do |word|
			Passwords.delay(priority: 2).add_cleartext_one(word, source)
		end
		file.close
		FileUtils.rm file_path
	end

end
