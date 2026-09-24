source 'https://rubygems.org'

ruby '>= 3.2'

gem 'rails', '7.2.3.2'
gem 'bootsnap', require: false
gem 'puma'
gem 'pg'
gem 'pg_search'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'foreman'
# Successor to the original librex git gem (that repo no longer exists);
# provides Rex::Text and Rex::Proto::NTLM::Crypt used for hash generation.
# require: false — the top-level rex.rb defines Kernel#select (a C select(2) port)
# that breaks ActionView 7.2's tag builder. We only use Rex::Text and
# Rex::Proto::NTLM::Crypt, which config/initializers/rex_ntlm.rb requires.
gem 'rex', '~> 2.0', require: false

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
