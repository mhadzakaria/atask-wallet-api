# frozen_string_literal: true

# The main controller for the application.
class ApplicationController < ActionController::API
  def authenticate!
    return if current_user.present?

    render json: { message: 'Please sign in first!' }
  end

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    @current_user ||= User.find_by(access_token: token)
  end
end
