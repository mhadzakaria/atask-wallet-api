class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :transaction_type
      t.references :source_wallet, null: false, foreign_key: true
      t.references :target_wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
