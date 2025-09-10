# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :outgoing_transactions, class_name: "Transaction", foreign_key: :source_wallet_id
  has_many :incoming_transactions, class_name: "Transaction", foreign_key: :target_wallet_id

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  before_create :fill_default_value

  private

  def fill_default_value
    self.last_sync_at = DateTime.now
  end
end

# == Schema Information
#
# Table name: wallets
#
#  id              :integer          not null, primary key
#  balance         :decimal(, )      default(0.0)
#  last_sync_at    :datetime
#  walletable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  walletable_id   :integer          not null
#
# Indexes
#
#  index_wallets_on_walletable  (walletable_type,walletable_id)
#
