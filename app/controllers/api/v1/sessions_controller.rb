# frozen_string_literal: true

module Api
  module V1
    # Handles user sign-in and sign-out.
    class SessionsController < Api::BaseController
      before_action :authenticate!, only: :destroy

      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          user.update(access_token: SecureRandom.hex(20))
          render json: { access_token: user.access_token }
        else
          render json: { error: 'User not found' }, status: :unauthorized
        end
      end

      def destroy
        user = current_user
        user&.update(access_token: nil)
        render json: { message: 'Signed out' }
      end
    end
  end
end
