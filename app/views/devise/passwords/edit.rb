class Views::Devise::Passwords::Edit < Views::Layouts::Application
  needs :minimum_password_length => nil
  
  def main
    h2("Change your password")

    text(simple_form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :put }) do |f|

      text(f.error_notification)
text " "
      text(f.input :reset_password_token, as: :hidden)
text " "
      text(f.full_error :reset_password_token)


      div(:class => "form-inputs") {
        text(f.input :password, label: "New password", required: true, autofocus: true, hint: ("#{minimum_password_length} characters minimum" if minimum_password_length))
text " "
        text(f.input :password_confirmation, label: "Confirm your new password", required: true)
      }


      div(:class => "form-actions") {
        text(f.button :submit, "Change my password")
      }
    end)
text " "
    render "devise/shared/links"
  end
end
