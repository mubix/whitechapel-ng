# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Statuses.find_or_create_by(name: "new")
Statuses.find_or_create_by(name: "hash")
Statuses.find_or_create_by(name: "generated")
Statuses.find_or_create_by(name: "cracked")


Types.find_or_create_by(name: "lm")
Types.find_or_create_by(name: "ntlm")
Types.find_or_create_by(name: "ntlmv1")
Types.find_or_create_by(name: "md5")
Types.find_or_create_by(name: "sha1")
Types.find_or_create_by(name: "sha256")
Types.find_or_create_by(name: "sha512")
Types.find_or_create_by(name: "mysql")
