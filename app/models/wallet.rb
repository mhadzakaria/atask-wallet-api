class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :outgoing_transactions, class_name: "Transaction", foreign_key: :source_wallet_id
  has_many :incoming_transactions, class_name: "Transaction", foreign_key: :target_wallet_id

  def balance
    incoming_transactions.sum(:amount) - outgoing_transactions.sum(:amount)
  end
end

# == Schema Information
#
# Table name: wallets
#
#  id              :integer          not null, primary key
#  balance         :decimal(, )
#  walletable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  walletable_id   :integer          not null
#
# Indexes
#
#  index_wallets_on_walletable  (walletable_type,walletable_id)
#
