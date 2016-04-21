Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: BeaconConfiguration.smtp_address,
    port: (BeaconConfiguration.smtp_port.presence || 465).to_i,
    enable_starttls_auto: BeaconConfiguration.smtp_starttls_auto == '1',
    user_name: BeaconConfiguration.smtp_user.presence,
    password: BeaconConfiguration.smtp_password.presence,
    authentication: BeaconConfiguration.smtp_authentication.presence.
                      try(:to_sym),
    domain: BeaconConfiguration.smtp_domain.presence ||
            BeaconConfiguration.base_domain,
    ssl: BeaconConfiguration.smtp_ssl == '1'
  }
end
