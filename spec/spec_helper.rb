require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

SimpleCov.start 'rails' do
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ])
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/its'
require 'capybara/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

Warden.test_mode!

RSpec.configure do |c|
  c.infer_spec_type_from_file_location!
  c.use_transactional_fixtures = false
  c.order = 'random'

  c.include FactoryGirl::Syntax::Methods
  c.include AbstractController::Translation
  c.include Warden::Test::Helpers
end

Capybara.javascript_driver = :webkit
