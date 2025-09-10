# frozen_string_literal: true

class WalletSerializer < ActiveModel::Serializer
  attributes :id, :balance, :owner_type, :owner_id, :owner_name

  def owner_type
    object.walletable_type
  end

  def owner_id
    object.walletable_id
  end

  def owner_name
    object.walletable.name
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
