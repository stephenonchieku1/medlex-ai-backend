module Api
  module V1
    class UsersController < BaseController
      skip_before_action :authenticate_user, only: [:create]

      def create
        @user = User.new(user_params)
        if @user.save
          render json: {
            token: @user.auth_token,
            user: {
              id: @user.id,
              email: @user.email
            }
          }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end 