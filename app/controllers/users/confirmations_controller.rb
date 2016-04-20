module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # Automatically sign in after confirming email address.
    def show
      super do
        if resource.errors.empty?
          sign_in(resource)
        end
      end
    end
  end
end
