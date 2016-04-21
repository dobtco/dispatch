class Mailer < ActionMailer::Base
  include BuildEmailAddressHelper

  layout 'base_mailer'

  def search_results(user, opportunity_ids)
    @user = user
    @opportunities = Opportunity.
                      where(id: opportunity_ids).
                      order_by_recently_posted

    mail(
      from: default_from_address,
      to: build_email_address(user.email, user.name),
      subject: t(
        'mailers.search_results.subject',
        site_title: Rails.configuration.x.site_title
      )
    )
  end

  private

  def default_from_address
    build_email_address(
      Rails.configuration.x.email_notification_from_address,
      Rails.configuration.x.site_title
    )
  end
end
