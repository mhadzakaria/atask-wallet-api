# frozen_string_literal: true

module Api
  module V1
    # Handles the creation of deposits, withdrawals, and transfers.
    class TransactionsController < Api::BaseController
      def create_deposit
        create_transaction(:deposit, target_wallet: find_wallet(params[:target_type], params[:target_id]))
      end

      def create_withdraw
        create_transaction(:withdraw, source_wallet: find_wallet(params[:source_type], params[:source_id]))
      end

      def create_transfer
        create_transaction(
          :transfer,
          source_wallet: find_wallet(params[:source_type], params[:source_id]),
          target_wallet: find_wallet(params[:target_type], params[:target_id])
        )
      end

      private

      def create_transaction(type, wallets)
        transaction = TransactionCreator.call(type: type.to_s.classify, amount: params[:amount], **wallets)
        render json: transaction, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def find_wallet(type, id = nil)
        return nil unless type && id

        @find_wallet_cache ||= {}
        @find_wallet_cache["#{type}-#{id}"] ||= case type.downcase
                                                when 'user'
                                                  User.find_by(id: id)&.wallet
                                                when 'team'
                                                  Team.find_by(id: id)&.wallet
                                                when 'stock'
                                                  Stock.find_by(id: id)&.wallet
                                                end
      end
    end
  end
end
