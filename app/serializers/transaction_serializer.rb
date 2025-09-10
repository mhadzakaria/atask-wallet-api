# frozen_string_literal: true

class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :created_at

  belongs_to :source_wallet, serializer: WalletSerializer
  belongs_to :target_wallet, serializer: WalletSerializer
end

# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  amount           :decimal(, )
#  type             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  source_wallet_id :integer
#  target_wallet_id :integer
#
# Indexes
#
#  index_transactions_on_source_wallet_id  (source_wallet_id)
#  index_transactions_on_target_wallet_id  (target_wallet_id)
#
# Foreign Keys
#
#  source_wallet_id  (source_wallet_id => wallets.id)
#  target_wallet_id  (target_wallet_id => wallets.id)
#
