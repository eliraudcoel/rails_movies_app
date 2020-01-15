module Api
  module V1
    class Api::SessionsController < ApiController
      # skip_before_action :verify_authenticity_token!, only: %i(create)

      def create
        @user = User.find_by(email: user_params[:email])
        raise Exceptions::EmailNotFound unless @user

        # and check for the password validity
        raise Exceptions::InvalidPassword unless @user.valid_password?(user_params[:password])

        byebug
        # We are now *sure* of the user's identify: we can grant him a new access token
        @access_token = @user.jti

        sign_in(resource_name, resource)
        respond_with resource, location:
          after_sign_in_path_for(resource) do |format|
            format.json { render json: 
                            { 
                              success: true,
                              jwt: current_token,
                              response: "Authentication successful"
                            }
                        }
        end

        # render template: "api/v1/sessions/create.json.jbuilder"
      end

      def destroy
        # cancel_user_tokens
        head 204
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
