class Views::Devise::Mailer::ConfirmationInstructions < Views::Mailer::Base
  def main
    p {
      text "Welcome "
      text(email)
      text "!"
    }

    p("You can confirm your account email through the link below:")

    p {
      link_to 'Confirm my account', confirmation_url(resource, confirmation_token: token)
    }
  end
end
