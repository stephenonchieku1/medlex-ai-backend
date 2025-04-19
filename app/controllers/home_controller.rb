class HomeController < ApplicationController
  skip_before_action :authenticate_user
  
  def index
    render json: { message: 'Welcome to Medlex AI API', version: '1.0.0' }
  end
end 