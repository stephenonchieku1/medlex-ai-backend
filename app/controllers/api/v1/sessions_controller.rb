module Api
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate_user, only: [:create]

      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          render json: {
            token: user.auth_token,
            user: {
              id: user.id,
              email: user.email
            }
          }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        current_user.invalidate_token
        head :no_content
      end
    end
  end
end 