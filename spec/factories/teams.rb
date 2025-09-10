# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Company.name }
  end
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
