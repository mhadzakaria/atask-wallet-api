class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_wallets

  def validate_wallets
    if source_wallet.nil? && target_wallet.nil?
      errors.add(:base, "Source or Target wallet must exist")
    end
  end
end
