class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound,
              with: :not_found

  rescue_from Pundit::NotAuthorizedError,
              with: :deny_access

  def not_found(_e = nil)
    raise ActionController::RoutingError.new('Not Found')
  end

  def deny_access(*)
    respond_to do |format|
      format.any(:js, :json, :xml) { head :unauthorized }
      format.any do
        if signed_in?
          redirect_to root_path, error: t('access_denied')
        else
          redirect_to new_user_session_path
        end
      end
    end
  end

  def authorize_staff
    unless current_user.try(:permission_level_is_at_least?, 'staff')
      deny_access
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :email,
        :name,
        :password,
        :business_name,
        :business_data,
        category_ids: []
      )
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :email,
        :name,
        :password,
        :password_confirmation,
        :current_password,
        :business_name,
        :business_data,
        category_ids: []
      )
    end
  end
end
