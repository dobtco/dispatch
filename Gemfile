source 'https://rubygems.org'

gem 'rails'

gem 'administrate'
gem 'autoprefixer-rails', github: 'ajb/autoprefixer-rails', branch: 'bundle-process'
gem 'bugsnag'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'coffee-rails'
gem 'delayed_job_active_record'
gem 'devise'
gem 'execjs'
gem 'factory_girl_rails'
gem 'filterer'
gem 'font-awesome-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'newrelic_rpm'
gem 'pg'
gem 'pundit'
gem 'premailer-rails'
gem 'rails_oneline_logging'
gem 'sassc-rails'
gem 'simple_form'
gem 'simple_form_legend'
gem 'sprockets-rails'
gem 'storage_unit'
gem 'uglifier'
gem 'utf8-cleaner'

source 'https://rails-assets.org' do
  gem 'rails-assets-inline_file_upload'
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-form'
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
  gem 'brakeman', require: false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'simplecov', require: false
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
