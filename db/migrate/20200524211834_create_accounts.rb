class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.date :birth_date
      t.string :gender
      t.string :city
      t.string :state
      t.string :country
      t.string :referral_code
      t.integer :status, default: 0

      t.timestamps
    end
    
    add_index :accounts, :cpf,                   unique: true
    add_index :accounts, :referral_code,         unique: true
  end
end
