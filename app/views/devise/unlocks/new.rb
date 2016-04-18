class Views::Devise::Unlocks::New < Views::Layouts::Application
  def main
    h2("Resend unlock instructions")

    text(simple_form_for(resource, as: resource_name, url: unlock_path(resource_name), html: { method: :post }) do |f|

      text(f.error_notification)
text " "
      text(f.full_error :unlock_token)


      div(:class => "form-inputs") {
        text(f.input :email, required: true, autofocus: true)
      }


      div(:class => "form-actions") {
        text(f.button :submit, "Resend unlock instructions")
      }
    end)
text " "
    render "devise/shared/links"
  end
end
