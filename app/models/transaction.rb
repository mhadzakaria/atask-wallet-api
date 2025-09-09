class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :amount, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  amount           :decimal(, )
#  transaction_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  source_wallet_id :integer          not null
#  target_wallet_id :integer          not null
#
# Indexes
#
#  index_transactions_on_source_wallet_id  (source_wallet_id)
#  index_transactions_on_target_wallet_id  (target_wallet_id)
#
# Foreign Keys
#
#  source_wallet_id  (source_wallet_id => source_wallets.id)
#  target_wallet_id  (target_wallet_id => target_wallets.id)
#
