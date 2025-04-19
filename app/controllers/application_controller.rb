class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user

  private

  def authenticate_user
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by(auth_token: token)
    end
  end

  def current_user
    @current_user
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
