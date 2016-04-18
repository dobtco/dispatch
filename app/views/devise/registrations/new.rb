class Views::Devise::Registrations::New < Views::Layouts::Application
  needs :minimum_password_length => nil
  
  def main
    h2("Sign up")

    text(simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f|

      text(f.error_notification)


      div(:class => "form-inputs") {
        text(f.input :email, required: true, autofocus: true)
text " "
        text(f.input :password, required: true, hint: ("#{minimum_password_length} characters minimum" if minimum_password_length))
text " "
        text(f.input :password_confirmation, required: true)
      }


      div(:class => "form-actions") {
        text(f.button :submit, "Sign up")
      }
    end)
text " "
    render "devise/shared/links"
  end
end
