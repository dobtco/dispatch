class Views::Devise::Confirmations::New < Views::Layouts::Application
  def main
    h2("Resend confirmation instructions")

    simple_form_for resource, as: resource_name, url: confirmation_path(resource_name), html: { method: :post } do |f|
      text(f.error_notification)
      text(f.full_error :confirmation_token)
      div(:class => "form-inputs") {
        f.input :email, required: true, autofocus: true
      }
      div(:class => "form-actions") {
        f.button :submit, "Resend confirmation instructions"
      }
    end

    render "devise/shared/links"
  end
end
