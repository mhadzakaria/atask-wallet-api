# frozen_string_literal: true

module Modules
  # Provides wallet-related functionality to models.
  module Walletable
    extend ActiveSupport::Concern

    included do
      has_one :wallet, as: :walletable, dependent: :destroy
    end

    def my_wallet
      return create_new_wallet if wallet.blank?

      wallet
    end

    def create_new_wallet
      build_wallet.save
      wallet
    end

    def generate_api_token
      self.access_token = SecureRandom.hex(20)
    end
  end
end
