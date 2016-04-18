require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Screendoor
  class Application < Rails::Application
    config.x.email_notification_from_address = 'noreply@dobt.co'

    # Autoload /lib classes
    config.autoload_paths << Rails.root.join('lib')

    # Manually bump assets
    config.assets.version = 'v1'

    # Add fonts to asset pipeline
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    config.assets.precompile += %w(
      .svg .eot .woff .ttf
      mailer.css
    )

    # Dump as SQL since we use some Postgres-specific db features
    config.active_record.schema_format = :sql

    config.active_record.raise_in_transactional_callbacks = true

    config.action_dispatch.rescue_responses.merge!(
      'ActionController::ParameterMissing' => :unprocessable_entity
    )
  end
end
