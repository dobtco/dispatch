class WhitelistInterceptor
  WHITELIST = BeaconConfiguration.staff_domains

  def self.delivering_email(message)
    original_to = message.to
    redirected = false

    message.to = Array(message.to).map do |address|
      whitelisted = false

      WhitelistInterceptor::WHITELIST.each do |whitelisted_address|
        break if whitelisted
        whitelisted = address.ends_with?("@#{whitelisted_address}")
      end

      if whitelisted
        address
      else
        redirected = true
        BeaconConfiguration.redirect_email_to
      end
    end

    message.subject = if redirected
                        "(#{original_to} #{Rails.env}) " + message.subject
                      else
                        "(#{Rails.env}) " + message.subject
                      end
  end
end

if Rails.env.staging?
  ActionMailer::Base.register_interceptor(WhitelistInterceptor)
end
