source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.7.1'

gem 'administrate', '~> 0.2.2'
gem 'autoprefixer-rails',
    github: 'ajb/autoprefixer-rails',
    branch: 'bundle-process'
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
gem 'pg_search'
gem 'pundit'
gem 'premailer-rails'

# Locked: https://github.com/premailer/premailer/issues/315
gem 'css_parser', '1.4.2'

gem 'rails_oneline_logging'
gem 'rinku'
gem 'sassc-rails'
gem 'simple_form'
gem 'simple_form_legend'
gem 'sprockets-rails'
gem 'storage_unit'
gem 'thin', require: false
gem 'uglifier'
gem 'utf8-cleaner'
gem 'whenever', require: false
gem 'yomu'

gem 'dvl-core', github: 'dobtco/dvl-core'
gem 'dvl-kaminari-views'

source 'https://rails-assets.org' do
  gem 'rails-assets-inline_file_upload'
  gem 'rails-assets-jquery-form'
  gem 'rails-assets-jquery-timeago'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-jquery'
  gem 'rails-assets-rome'
  gem 'rails-assets-selectize'
  gem 'rails-assets-underscore'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload', require: false
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'launchy'
  gem 'letter_opener'
  gem 'spring-commands-rspec'
  gem 'spring'
end

group :test do
  gem 'brakeman', require: false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'codeclimate-test-reporter', '~> 0.6', require: false
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'webmock'
end

group :development, :test do
  gem 'i18n-tasks'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.41.1', require: false
end

group :production do
  gem 'rails_12factor'
end
