# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Statuses.new(name: "new").save
Statuses.new(name: "hash").save
Statuses.new(name: "cleartext").save

Types.new(name: "LM").save
Types.new(name: "NTLM").save
Types.new(name: "NTLMv1").save
Types.new(name: "MD5").save
Types.new(name: "SHA1").save
Types.new(name: "SHA256").save
Types.new(name: "SHA512").save
Types.new(name: "MySQL").save
