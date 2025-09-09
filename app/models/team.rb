class Team < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy
end

# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
