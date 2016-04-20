class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :set_signup_type, only: [:new, :create]
  before_filter :set_edit_type, only: [:edit, :update]

  def update_resource(resource, params)
    if params.key?(:current_password)
      super
    else
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def set_signup_type
    params[:type] = 'vendor' unless params[:type].in?(%w(vendor staff))
  end

  def set_edit_type
    params[:type] = 'account' unless params[:type].in?(%w(account password))
  end
end
