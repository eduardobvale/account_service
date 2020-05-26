class AddReferrerCodeToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :referrer_code, :string
  end
end
