# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

ActiveRecord::Migration.maintain_test_schema!

# Ensure the hash types/statuses the app generates exist (normally
# created by db/seeds.rb).
def ensure_seed_data!
  Statuses.find_or_create_by!(name: "generated")
  %w[lm ntlm ntlmv1 md5 sha1 sha256 sha512 mysql].each do |name|
    Types.find_or_create_by!(name: name)
  end
end

RSpec.configure do |config|
  # rspec-rails allows you to reduce or eliminate the number of times
  # RSpec loads the Rails environment, which can increase test speed.
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
