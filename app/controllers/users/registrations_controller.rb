class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :set_signup_type, only: [:create, :update]

  def set_signup_type
    params[:type] = 'vendor' unless params[:type].in?(%w(vendor staff))
  end
end
