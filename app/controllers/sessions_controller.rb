class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
      render json: { message: "Signed in" }
    else
      render json: { error: "User not found" }, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    render json: { message: "Signed out" }
  end
end
