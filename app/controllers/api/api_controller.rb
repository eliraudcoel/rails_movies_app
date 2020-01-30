module Api
  module V1
    class ApiController < ActionController::Base
      # Allow use to user authenticate_with_http_token
      include ActionController::HttpAuthentication::Token

      include TokenAuthentication
      include ErrorRescuer
    
    end
  end
end
