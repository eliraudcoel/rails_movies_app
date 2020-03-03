module Api
  module V1
    class Api::SessionsController < ApiController

      # Skip verify_authenticity_token
      # Error display : Can't verify CSRF token authenticity
      # Fix Reference : https://stackoverflow.com/a/43122403
      skip_before_action :verify_authenticity_token, only: [:create]

      # Skip authenticate_with_token! from TokenAuthentication concern
      # In this cas we don't care about token in HTTP request header
      skip_before_action :authenticate_with_token!, only: [:create]

      def create
        @user = User.find_by(email: user_params[:email])

        raise Exceptions::EmailNotFound unless @user

        # and check for the password validity
        raise Exceptions::InvalidPassword unless @user.valid_password?(user_params[:password])

        # We are now *sure* of the user's identify: we can grant him a new access token
        @access_token = JsonWebToken.encode({user_id: @user.id, user_email: @user.email})

        # render template: "api/v1/sessions/create.json.jbuilder"
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end