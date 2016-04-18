Rails.application.configure do
  config.x.ssl = true
  config.x.base_domain = 'screendoor.dobt.co'
  config.x.program_name = 'screendoor-production'
  config.x.forms_domain = 'forms.fm'

  config.middleware.use Rack::SslEnforcer, ignore: [
    %r{^\/embedded}
  ], hsts: true
end

require_relative '_shared_staging_production'
require_relative '_shared'
