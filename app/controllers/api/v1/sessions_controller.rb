module Api
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate_user, only: [:create]

      def create
        email = params[:email] || params.dig(:session, :email)
        password = params[:password] || params.dig(:session, :password)
        
        user = User.find_by(email: email)
        if user&.authenticate(password)
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