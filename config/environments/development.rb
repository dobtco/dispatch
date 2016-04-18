Rails.application.configure do
  config.cache_store = :memory_store

  config.cache_classes = false
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false
  config.assets.digest = false

  config.x.ssl = false
  config.x.base_domain = ENV['HOST'] || 'localhost:3000'

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
end

require_relative '_shared'
