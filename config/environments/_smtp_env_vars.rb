Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'],
    port: (ENV['SMTP_PORT'].presence || 465).to_i,
    enable_starttls_auto: ENV['SMTP_STARTTLS_AUTO'] == '1',
    user_name: ENV["SMTP_USER"].presence,
    password: ENV["SMTP_PASSWORD"].presence,
    authentication: ENV['SMTP_AUTHENTICATION'].presence.try(:to_sym),
    domain: ENV['SMTP_DOMAIN'].presence || config.x.base_domain,
    ssl: ENV['SMTP_SSL'] == '1'
  }
end
