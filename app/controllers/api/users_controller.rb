module Api
  module V1
    class Api::UsersController < ApiController
      # include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::HttpAuthentication::Token

      def show
        # Get current user informations
        @user = User.find(params[:id])

        if @user && @current_user && @current_user != @user
          raise Exceptions::AccessRestricted.new
        end

        # and check if user exist
        raise Exceptions::UserNotFound unless @user
      end
    end
  end
end
