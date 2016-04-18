class Views::Devise::Sessions::New < Views::Layouts::Application
  def main
    h2("Log in")

    simple_form_for resource, as: resource_name, url: session_path(resource_name) do |f|
      div(:class => "form-inputs") {
        f.input :email, required: false, autofocus: true
        f.input :password, required: false
        f.input :remember_me, as: :boolean if devise_mapping.rememberable?
      }

      div(:class => "form-actions") {
        f.button :submit, "Log in"
      }
    end

    render "devise/shared/links"
  end
end
