# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Creating user for Ahmad Zakaria...'
user = FactoryBot.create(:user, name: 'Ahmad Zakaria', email: 'azak808@gmail.com')

puts 'Creating users...'
10.times do
  user = FactoryBot.create(:user)
  FactoryBot.create(:wallet, :for_user, walletable: user)
end

puts 'Creating teams...'
3.times do
  team = FactoryBot.create(:team)
  FactoryBot.create(:wallet, :for_team, walletable: team)
end

puts 'Creating transactions...'
5.times do
  FactoryBot.create(:transaction, :deposit)
end

5.times do
  FactoryBot.create(:transaction, :withdraw)
end

10.times do
  FactoryBot.create(:transaction, :transfer)
end

puts 'Seed data created successfully!'
