class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.references :client, foreign_key: true
      t.string :account_number
      t.decimal :balance

      t.timestamps
    end
  end
end
