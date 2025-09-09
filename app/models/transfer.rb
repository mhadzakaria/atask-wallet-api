class Transfer < Transaction
  validates :source_wallet, presence: true
  validates :target_wallet, presence: true
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
