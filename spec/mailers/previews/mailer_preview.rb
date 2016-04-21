class MailerPreview < ActionMailer::Preview
  def search_results
    Mailer.search_results(
      User.first || FactoryGirl.create(:user),
      Opportunity.limit(3)
    )
  end
end
