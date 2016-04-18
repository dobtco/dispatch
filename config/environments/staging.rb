Rails.application.configure do
  config.x.ssl = true
  config.x.base_domain = 'tbd'
end

require_relative '_shared_staging_production'
require_relative '_shared'
