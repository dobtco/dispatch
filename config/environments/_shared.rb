# This stuff needs to be loaded *after* the environment-specific config,
# otherwise we'd just toss it in config/application.rb
Rails.application.configure do
  # Check for Configuration.asset_host, our Cloudfront URL
  if Configuration.asset_host.present?
    config.action_controller.asset_host = Configuration.asset_host
  end

  # Set "host with protocol", which is a nice variable to have
  host_with_protocol = "http#{Configuration.ssl ? 's' : ''}://" +
                       Configuration.base_domain

  # Use the above variable to set some default URL options
  routes.default_url_options[:host] = host_with_protocol
  config.action_mailer.default_url_options = {
    host: host_with_protocol
  }

  # Set the asset host for our emails
  config.action_mailer.asset_host = config.action_controller.asset_host ||
                                    "//#{Configuration.base_domain}"

  if Configuration.ssl
    config.force_ssl = true
  end
end
