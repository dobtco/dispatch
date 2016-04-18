Rails.application.configure do
  config.x.ssl = true
  config.x.base_domain = 'screendoor.staging.dobt.co'
  config.x.program_name = 'screendoor-staging'
  config.x.forms_domain = 'formsfmstaging.com'

  config.middleware.use Rack::SslEnforcer, ignore: [
    %r{^\/embedded},
    %r{^\/email_processor},
    %r{^\/api},
    %r{^\/stripe_events}
  ], hsts: true

  require 'rack/attack'

  config.middleware.use Rack::Attack

  Rack::Attack.whitelist('allow users with the staging environment cookie') do |req|
    req.cookies['staging_environment_key'] == 'lol'
  end

  Rack::Attack.whitelist('allow paths that are hitting API-ish endpoints') do |req|
    req.path.start_with?('/api') ||
    req.path.start_with?('/email_processor') ||
    req.path.start_with?('/stripe_events') ||
    req.path.start_with?('/dobt_hooks')
  end

  Rack::Attack.blacklist('everything else') do |req|
    true
  end
end

require_relative '_shared_staging_production'
require_relative '_shared'
