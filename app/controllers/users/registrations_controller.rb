module Users
  class RegistrationsController < Devise::RegistrationsController
    before_filter :set_signup_type, only: [:new, :create]
    before_filter :set_edit_type, only: [:edit, :update]

    def confirm
      require_no_authentication
    end

    def update_resource(resource, params)
      if params.key?(:current_password)
        super
      else
        resource.update_without_password(params)
      end
    end

    def after_inactive_sign_up_path_for(_resource)
      flash.delete(:notice) # Don't display a redundant flash
      users_confirm_path
    end

    def after_update_path_for(_resource)
      edit_user_registration_path
    end

    def set_signup_type
      @signup_type = params[:type] == 'staff' ? :staff : :vendor
    end

    def set_edit_type
      @edit_type = params[:type] == 'password' ? :password : :account
    end

    def sign_up_params
      super.tap do |h|
        h[:signup_type] = @signup_type
      end
    end
  end
end
