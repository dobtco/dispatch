class Views::Devise::Passwords::New < Views::Layouts::Application
  def main
    h2("Forgot your password?")

    text(simple_form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :post }) do |f|

      text(f.error_notification)


      div(:class => "form-inputs") {
        text(f.input :email, required: true, autofocus: true)
      }


      div(:class => "form-actions") {
        text(f.button :submit, "Send me reset password instructions")
      }
    end)
text " "
    render "devise/shared/links"
  end
end
