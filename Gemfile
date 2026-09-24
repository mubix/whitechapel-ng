source 'https://rubygems.org'

ruby '>= 3.2'

gem 'rails', '~> 7.1.0'
gem 'bootsnap', require: false
gem 'puma'
gem 'pg'
gem 'pg_search'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'foreman'
# Successor to the original librex git gem (that repo no longer exists);
# provides Rex::Text and Rex::Proto::NTLM::Crypt used for hash generation.
gem 'rex', '~> 2.0'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner-active_record'
end

group :test do
  gem 'selenium-webdriver'
end

gem 'sass-rails', '~> 6.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.2'
