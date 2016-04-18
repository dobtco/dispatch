class Views::Devise::Registrations::Edit < Views::Layouts::Application
  def main
    h2 {
      text "Edit "
      text(resource_name.to_s.humanize)
    }


    text(simple_form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f|

      text(f.error_notification)


      div(:class => "form-inputs") {
        text(f.input :email, required: true, autofocus: true)
text " "
        if devise_mapping.confirmable? && resource.pending_reconfirmation?
          p {
            text "Currently waiting confirmation for: "
            text(resource.unconfirmed_email)
          }
        end
text " "
        text(f.input :password, autocomplete: "off", hint: "leave it blank if you don't want to change it", required: false)
text " "
        text(f.input :password_confirmation, required: false)
text " "
        text(f.input :current_password, hint: "we need your current password to confirm your changes", required: true)
      }


      div(:class => "form-actions") {
        text(f.button :submit, "Update")
      }
    end)

    h3("Cancel my account")

    p {
      text "Unhappy? "
      link_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete
    }


    link_to "Back", :back
  end
end
