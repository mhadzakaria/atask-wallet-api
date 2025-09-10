# frozen_string_literal: true

module Api
  module V1
    # Handles wallet-related actions.
    class WalletsController < Api::BaseController
      def show
        wallet = find_wallet(params[:wallet_type], params[:wallet_id])
        if wallet
          render json: wallet
        else
          render json: { error: 'Wallet not found' }, status: :not_found
        end
      end

      private

      def find_wallet(type, id = nil)
        return nil unless type && id

        @find_wallet_cache ||= {}
        @find_wallet_cache["#{type}-#{id}"] ||= case type.downcase
                                                when 'user'
                                                  User.find_by(id: id)&.my_wallet
                                                when 'team'
                                                  Team.find_by(id: id)&.my_wallet
                                                when 'stock'
                                                  Stock.find_by(id: id)&.my_wallet
                                                end
      end
    end
  end
end
