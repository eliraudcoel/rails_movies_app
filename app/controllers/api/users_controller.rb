module Api
  module V1
    class Api::UsersController < ApiController
      # include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::HttpAuthentication::Token

      def show
        # user = self.lookup_user_from_token
        byebug
        
        #TODO : make it retrieve from header token
        @user = User.find(params[:id])

        # and check if user exist
        raise Exceptions::UserNotFound unless @user
      end
    end
  end
end
