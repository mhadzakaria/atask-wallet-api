class TransactionCreator
  def self.call(transaction_params)
    ActiveRecord::Base.transaction do
      transaction = Transaction.create!(transaction_params)

      # Update source wallet if present
      if transaction.source_wallet.present?
        update_wallet_balance(transaction.source_wallet)
      end

      # Update target wallet if present
      if transaction.target_wallet.present?
        update_wallet_balance(transaction.target_wallet)
      end

      transaction
    end
  end

  private

  def self.update_wallet_balance(wallet)
    wallet.balance = wallet.incoming_transactions.sum(:amount) - wallet.outgoing_transactions.sum(:amount)
    latest_transaction_time = [
      wallet.incoming_transactions.maximum(:created_at),
      wallet.outgoing_transactions.maximum(:created_at)
    ].compact.max
    wallet.last_sync_at = latest_transaction_time
    wallet.save!
  end
end
