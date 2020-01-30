module TokenAuthentication
  # Allow use to user authenticate_with_http_token
  include ActionController::HttpAuthentication::Token::ControllerMethods

  extend ActiveSupport::Concern

  included do
    # By default, automatically authenticate with the bearer token
    before_action :authenticate_with_token!
  end

  private

  def lookup_user_from_token
    user = nil
    # Rails method that parses the "Bearer" token, if any
    authenticate_with_http_token do |token, _options|
      @access_token = token
      user = User.find_by_access_token(token)
    end
    user
  end

  def current_user
    @current_user ||= lookup_user_from_token
  end

  def user_signed_in?
    !!current_user
  end

  def authenticate_with_token!
    raise Exceptions::InvalidToken.new unless user_signed_in?
  end

  # def authorization_header
  #   @http_authorization = request.env["HTTP_AUTHORIZATION"]
  #   @http_authorization = @http_authorization.split("Bearer ")[1]
  # end

  # def sign_user_in(user, access_token: nil)
  #   @current_user = user
  #   @access_token = access_token if access_token
  # end

  # def cancel_user_tokens
  #   token_objs = AccessToken.for_access_token(@access_token)
  #   token_objs.each(&:cancel!)
  # end
end
