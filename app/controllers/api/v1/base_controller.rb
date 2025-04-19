module Api
  module V1
    class BaseController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::ParameterMissing, with: :bad_request
      
      private
      
      def not_found
        render json: { error: 'Resource not found' }, status: :not_found
      end
      
      def bad_request
        render json: { error: 'Bad request' }, status: :bad_request
      end
    end
  end
end 