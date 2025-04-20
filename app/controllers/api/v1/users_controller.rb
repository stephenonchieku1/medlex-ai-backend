# module Api
#   module V1
#     class UsersController < BaseController
#       skip_before_action :authenticate_user, only: [:create]

#       def create
#         # Extract email and password from params
#         email = params[:email] || params.dig(:user, :email)
#         password = params[:password] || params.dig(:user, :password)
#         password_confirmation = params[:password_confirmation] || params.dig(:user, :password_confirmation)

#         @user = User.new(
#           email: email,
#           password: password,
#           password_confirmation: password_confirmation
#         )
        
#         if @user.save
#           render json: {
#             token: @user.auth_token,
#             user: {
#               id: @user.id,
#               email: @user.email
#             }
#           }, status: :created
#         else
#           render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
#         end
#       end

#       private

#       def user_params
#         params.permit(:email, :password, :password_confirmation)
#       end
#     end
#   end
# end
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