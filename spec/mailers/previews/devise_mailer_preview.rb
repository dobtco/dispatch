class Devise::MailerPreview < ActionMailer::Preview
  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(
      User.first || FactoryGirl.create(:user),
      'xxx'
    )
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(
      User.first || FactoryGirl.create(:user),
      'xxx'
    )
  end
end
