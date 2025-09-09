class TransactionsController < ApplicationController
  before_action :authenticate!

  def create_deposit
    ActiveRecord::Base.transaction do
      target_wallet = find_wallet(params[:target_type], params[:target_id])
      if target_wallet.nil?
        render json: { error: "Target wallet not found" }, status: :not_found
        return
      end

      deposit = Deposit.new(target_wallet: target_wallet, amount: params[:amount])

      if deposit.save
        render json: deposit, status: :created
      else
        render json: { errors: deposit.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def create_withdraw
    ActiveRecord::Base.transaction do
      source_wallet = find_wallet(params[:source_type], params[:source_id])
      if source_wallet.nil?
        render json: { error: "Source wallet not found" }, status: :not_found
        return
      end

      withdraw = Withdraw.new(source_wallet: source_wallet, amount: params[:amount])

      if withdraw.save
        render json: withdraw, status: :created
      else
        render json: { errors: withdraw.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def create_transfer
    ActiveRecord::Base.transaction do
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

      transfer = Transfer.new(source_wallet: source_wallet, target_wallet: target_wallet, amount: params[:amount])

      if transfer.save
        render json: transfer, status: :created
      else
        render json: { errors: transfer.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def find_wallet(type, id)
    case type.downcase
    when "user"
      User.find_by(id: id)&.wallet
    when "team"
      Team.find_by(id: id)&.wallet
    when "stock"
      Stock.find_by(id: id)&.wallet
    else
      nil
    end
  end
end