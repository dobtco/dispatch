require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

# Don't dump database structure in deployed environments
Rake::Task["db:structure:dump"].clear if Rails.env.in? %w(production staging)

# Log to console in development
if Rails.env.development?
  Rails.logger = Logger.new(STDOUT)
end
