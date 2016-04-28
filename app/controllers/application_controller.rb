class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepend_view_paths
  after_action :verify_authorized, unless: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound,
              with: :not_found

  rescue_from Pundit::NotAuthorizedError,
              with: :deny_access

  def not_found(_e = nil)
    raise ActionController::RoutingError, 'Not Found'
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
    skip_authorization
    deny_access unless current_user.try(:permission_level_is_at_least?, 'staff')
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        :email,
        :name,
        :password,
        :business_name,
        subscribe_to_category_ids: [],
        business_data: Array(u[:business_data].try(:keys))
      )
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(
        :email,
        :name,
        :password,
        :password_confirmation,
        :current_password,
        :business_name,
        business_data: Array(u[:business_data].try(:keys))
      )
    end
  end

  before_filter :prepend_view_paths

  def prepend_view_paths
    prepend_view_path DispatchConfiguration.theme_path.join('views')
  end
end
