module Api
  module V1
    class Api::UsersController < ApiController
      # include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::HttpAuthentication::Token

      # Skip verify_authenticity_token
      # Error display : Can't verify CSRF token authenticity
      # Fix Reference : https://stackoverflow.com/a/43122403
      skip_before_action :verify_authenticity_token, only: [:create]

      # Skip authenticate_with_token! from TokenAuthentication concern
      # In this cas we don't care about token in HTTP request header
      skip_before_action :authenticate_with_token!, only: [:create]
      
      def show
        # Get current user informations
        @user = User.find(user_params[:id])

        if @user && @current_user && @current_user != @user
          raise Exceptions::AccessRestricted.new
        end

        # and check if user exist
        raise Exceptions::UserNotFound unless @user
      end

      def create
        # we check if user isn't already exist
        raise Exceptions::EmailAlreadyUsed if User.find_by_email(user_params[:email])

        @user = User.create(email: user_params[:email], password: user_params[:password])

        # We are now *sure* of the user's identify: we can grant him a new access token
        @access_token = JsonWebToken.encode({user_id: @user.id, user_email: @user.email})
      end

      private

      def user_params
        params.permit(:id, :email, :password)
      end
    end
  end
end
