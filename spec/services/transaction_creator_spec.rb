# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionCreator do
  describe '.call' do
    let(:user_wallet) { create(:wallet, :for_user, balance: 1000) }
    let(:team_wallet) { create(:wallet, :for_team, balance: 500) }
    
    context 'Deposit transaction' do
      it 'creates a deposit transaction and updates target wallet balance' do
        create(:transaction, :deposit, target_wallet: user_wallet, amount: 1000)
        transaction_params = {
          type: 'Deposit',
          amount: 200,
          target_wallet: user_wallet
        }

        expect do
          TransactionCreator.call(transaction_params)
        end.to change(Transaction, :count).by(1)

        user_wallet.reload
        expect(user_wallet.balance.to_f).to eq(1200.0)
      end
    end

    context 'Withdraw transaction' do
      it 'creates a withdraw transaction and updates source wallet balance' do
        create(:transaction, :deposit, target_wallet: user_wallet, amount: 1000)

        transaction_params = {
          type: 'Withdraw',
          amount: 300,
          source_wallet: user_wallet
        }

        expect do
          TransactionCreator.call(transaction_params)
        end.to change(Transaction, :count).by(1)

        user_wallet.reload
        expect(user_wallet.balance.to_f).to eq(700.0)
      end

      it 'raises an error for insufficient funds' do
        transaction_params = {
          type: 'Withdraw',
          amount: 1500,
          source_wallet: user_wallet
        }

        expect do
          TransactionCreator.call(transaction_params)
        end.to raise_error(ActiveRecord::RecordInvalid, /Insufficient funds in source wallet/)
      end
    end

    context 'Transfer transaction' do
      it 'creates a transfer transaction and updates both wallet balances' do
        create(:transaction, :deposit, target_wallet: user_wallet, amount: 1000)
        create(:transaction, :deposit, target_wallet: team_wallet, amount: 500)

        transaction_params = {
          type: 'Transfer',
          amount: 100,
          source_wallet: user_wallet,
          target_wallet: team_wallet
        }

        expect do
          TransactionCreator.call(transaction_params)
        end.to change(Transaction, :count).by(1)

        user_wallet.reload
        team_wallet.reload
        expect(user_wallet.balance.to_f).to eq(900.0)
        expect(team_wallet.balance.to_f).to eq(600.0)
      end

      it 'raises an error for insufficient funds' do
        transaction_params = {
          type: 'Transfer',
          amount: 1500,
          source_wallet: user_wallet,
          target_wallet: team_wallet
        }

        expect do
          TransactionCreator.call(transaction_params)
        end.to raise_error(ActiveRecord::RecordInvalid, /Insufficient funds in source wallet/)
      end
    end
  end
end
