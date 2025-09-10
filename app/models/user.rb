# frozen_string_literal: true

# Represents a user in the system.
class User < ApplicationRecord
  include Modules::Walletable

  has_secure_password

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
