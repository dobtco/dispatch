require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Dispatch
  class Application < Rails::Application
    # Autoload /lib classes
    config.autoload_paths << Rails.root.join('lib')

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

    config.active_job.queue_adapter = :delayed_job

    config.action_view.raise_on_missing_translations = true
  end
end
