class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 0
      t.references :walletable, polymorphic: true, null: false
      t.datetime :last_sync_at

      t.timestamps
    end
  end
end
