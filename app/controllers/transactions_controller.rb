class TransactionsController < ApplicationController
  before_action :authenticate!

  def create_deposit
    target_wallet = find_wallet(params[:target_type], params[:target_id])
    if target_wallet.nil?
      render json: { error: "Target wallet not found" }, status: :not_found
      return
    end

    begin
      deposit = TransactionCreator.call(target_wallet: target_wallet, amount: params[:amount], type: 'Deposit')
      render json: deposit, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def create_withdraw
    source_wallet = find_wallet(params[:source_type], params[:source_id])
    if source_wallet.nil?
      render json: { error: "Source wallet not found" }, status: :not_found
      return
    end

    begin
      withdraw = TransactionCreator.call(source_wallet: source_wallet, amount: params[:amount], type: 'Withdraw')
      render json: withdraw, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def create_transfer
    source_wallet = find_wallet(params[:source_type], params[:source_id])
    target_wallet = find_wallet(params[:target_type], params[:target_id])

    if source_wallet.nil?
      render json: { error: "Source wallet not found" }, status: :not_found
      return
    end

    if target_wallet.nil?
      render json: { error: "Target wallet not found" }, status: :not_found
      return
    end

    begin
      transfer = TransactionCreator.call(source_wallet: source_wallet, target_wallet: target_wallet, amount: params[:amount], type: 'Transfer')
      render json: transfer, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def find_wallet(type, id = nil)
    @wallet ||= case type.downcase
                when "user"
                  User.find_by(id: id)&.wallet
                when "team"
                  Team.find_by(id: id)&.wallet
                when "stock"
                  Stock.find_by(id: id)&.wallet
                when "my_wallet"
                  current_user.my_wallet
                else
                  nil
                end
  end
end