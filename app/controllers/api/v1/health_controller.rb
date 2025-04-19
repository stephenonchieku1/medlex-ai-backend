module Api
  module V1
    class HealthController < BaseController
      skip_before_action :authenticate_user
      
      def index
        render json: { status: 'ok', timestamp: Time.current }
      end
    end
  end
end 