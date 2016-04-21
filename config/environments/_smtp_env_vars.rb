Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: Configuration.smtp_address,
    port: (Configuration.smtp_port.presence || 465).to_i,
    enable_starttls_auto: Configuration.smtp_starttls_auto == '1',
    user_name: Configuration.smtp_user.presence,
    password: Configuration.smtp_password.presence,
    authentication: Configuration.smtp_authentication.presence.
                      try(:to_sym),
    domain: Configuration.smtp_domain.presence ||
            Configuration.base_domain,
    ssl: Configuration.smtp_ssl == '1'
  }
end
