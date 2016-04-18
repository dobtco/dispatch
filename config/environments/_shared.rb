# This stuff needs to be loaded *after* the environment-specific config,
# otherwise we'd just toss it in config/application.rb
Rails.application.configure do
  # Check for ENV['ASSET_HOST'], our Cloudfront URL
  if ENV['ASSET_HOST'].present?
    config.action_controller.asset_host = ENV['ASSET_HOST']
  end

  # Set "host with protocol", which is a nice variable to have
  config.x.host_with_protocol = "http#{config.x.ssl ? 's' : ''}://#{config.x.base_domain}"

  # Use the above variable to set some default URL options
  routes.default_url_options[:host] = config.x.host_with_protocol
  config.action_mailer.default_url_options = { host: config.x.host_with_protocol }

  # Set the asset host for our emails
  config.action_mailer.asset_host = config.action_controller.asset_host ||
                                    "//#{config.x.base_domain}"

  if config.x.ssl
    config.force_ssl = true
  end
end
