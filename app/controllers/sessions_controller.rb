class SessionsController < ApplicationController
  before_action :authenticate!, only: :destroy

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      user.update(access_token: SecureRandom.hex(20))
      render json: { access_token: user.access_token }
    else
      render json: { error: "User not found" }, status: :unauthorized
    end
  end

  def destroy
    user = current_user
    user.update(access_token: nil) if user
    render json: { message: "Signed out" }
  end
end
