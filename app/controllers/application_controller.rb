class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound,
              with: :not_found

  rescue_from Pundit::NotAuthorizedError,
              with: :deny_access

  def not_found(e = nil)
    raise ActionController::RoutingError.new('Not Found')
  end

  def deny_access(*)
    respond_to do |format|
      format.any(:js, :json, :xml) { head :unauthorized }
      format.any do
        if signed_in?
          redirect_to root_path, error: t('flash.error.access_denied')
        else
          redirect_to new_user_session_path # @todo redirect back to prev page
        end
      end
    end
  end

  def authorize_staff
    unless current_user.try(:permission_level_is_at_least?, 'staff')
      deny_access
    end
  end
end
