module Api
  module V1
    class SessionsController < ApiController

      def create
        @user = User.find_by(email: user_params[:email])
        raise Exceptions::EmailNotFound unless @user

        # and check for the password validity
        raise Exceptions::InvalidPassword unless @user.valid_password?(user_params[:password])

        # We are now *sure* of the user's identify: we can grant him a new access token
        @access_token = JsonWebToken.encode({user_id: @user.id, user_email: @user.email})

        # render template: "api/v1/sessions/create.json.jbuilder"
      end

      def destroy
        cancel_user_tokens
        head 204
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end