# frozen_string_literal: true

class Stock < ApplicationRecord
  include Modules::Walletable
end

# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
