class ApplicationController < ActionController::Base
  layout false

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound,
              with: :not_found

  def not_found(e = nil)
    raise ActionController::RoutingError.new('Not Found')
  end
end
