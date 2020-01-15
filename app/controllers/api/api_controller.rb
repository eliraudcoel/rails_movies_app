module Api
  module V1

    class ApiController < ActionController::API
      include TokenAuthentication
      include ErrorRescuer
      # include ApiErrors

      helper_method :current_user

      protected

      def load_user!
        @user = User.find(params[:id] || params[:user_id])
      end

      def ensure_is_current_user!
        raise Exceptions::InvalidUser.new unless @user == current_user
      end

      # Add elements to lograge payload
      def append_info_to_payload(payload)
        super
        payload[:remote_ip] = request.remote_ip
        payload[:request_id] = request.request_id
        payload[:user_id] = current_user.present? ? current_user.try(:id) : :guest
        payload[:filtered_params] = payload[:params].except("controller", "action", "format", "utf8")
      end
    end

  end
end
