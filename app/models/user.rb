class User < ApplicationRecord
  has_secure_password

  has_one :wallet, as: :walletable, dependent: :destroy

  before_create :generate_api_token

  private

  def generate_api_token
    self.access_token = SecureRandom.hex(20)
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  access_token    :string
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
