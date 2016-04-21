# This stuff needs to be loaded *after* the environment-specific config,
# otherwise we'd just toss it in config/application.rb
Rails.application.configure do
  # Check for BeaconConfiguration.asset_host, our Cloudfront URL
  if BeaconConfiguration.asset_host.present?
    config.action_controller.asset_host = BeaconConfiguration.asset_host
  end

  # Set "host with protocol", which is a nice variable to have
  host_with_protocol = "http#{BeaconConfiguration.ssl ? 's' : ''}://" +
                       BeaconConfiguration.base_domain

  # Use the above variable to set some default URL options
  routes.default_url_options[:host] = host_with_protocol
  config.action_mailer.default_url_options = {
    host: host_with_protocol
  }

  # Set the asset host for our emails
  config.action_mailer.asset_host = config.action_controller.asset_host ||
                                    "//#{BeaconConfiguration.base_domain}"

  if BeaconConfiguration.ssl
    config.force_ssl = true
  end
end
