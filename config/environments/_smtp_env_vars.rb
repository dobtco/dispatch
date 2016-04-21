Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: DispatchConfiguration.smtp_address,
    port: (DispatchConfiguration.smtp_port.presence || 465).to_i,
    enable_starttls_auto: DispatchConfiguration.smtp_starttls_auto == '1',
    user_name: DispatchConfiguration.smtp_user.presence,
    password: DispatchConfiguration.smtp_password.presence,
    authentication: DispatchConfiguration.smtp_authentication.presence.
                      try(:to_sym),
    domain: DispatchConfiguration.smtp_domain.presence ||
            DispatchConfiguration.base_domain,
    ssl: DispatchConfiguration.smtp_ssl == '1'
  }
end
