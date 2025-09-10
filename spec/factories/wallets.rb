# frozen_string_literal: true

FactoryBot.define do
  factory :wallet do
    balance { Faker::Commerce.price }

    trait :for_user do
      association :walletable, factory: :user
    end

    trait :for_team do
      association :walletable, factory: :team
    end
  end
end

# == Schema Information
#
# Table name: wallets
#
#  id              :integer          not null, primary key
#  balance         :decimal(, )
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
