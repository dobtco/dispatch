source 'https://rubygems.org'

gem 'rails'

gem 'bugsnag'
gem 'coffee-rails'
gem 'delayed_job_active_record'
gem 'devise'
gem 'execjs'
gem 'factory_girl_rails'
gem 'font-awesome-rails'
gem 'newrelic_rpm'
gem 'lite_enum'
gem 'pg'
gem 'premailer-rails'
gem 'rails_oneline_logging'
gem 'sassc-rails'
gem 'simple_form'
gem 'simple_form_legend'
gem 'sprockets-rails'
gem 'uglifier'
gem 'utf8-cleaner'

source 'https://rails-assets.org' do
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-underscore'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload', require: false
  gem 'guard-rspec'
  gem 'launchy'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'rspec-its'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'rspec-rails'
  gem 'thin', require: false
end

group :staging, :production do
  gem 'remote_syslog_logger'
end
