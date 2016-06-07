module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
      flash[:notice] = t('devise.omniauth_callbacks.success', kind: 'Google')
      sign_in_and_redirect @user, event: :authentication
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.record.errors.full_messages.to_sentence
      redirect_to new_user_session_path
    end
  end
end
