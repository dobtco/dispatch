class CustomDeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    CustomDeviseMailer.confirmation_instructions(
      User.first || FactoryGirl.create(:user),
      'xxx'
    )
  end

  def reset_password_instructions
    CustomDeviseMailer.reset_password_instructions(
      User.first || FactoryGirl.create(:user),
      'xxx'
    )
  end
end
