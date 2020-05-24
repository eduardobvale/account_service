class AddReferrerIdToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts, :referrer, foreign_key: { to_table: :accounts }
  end
end
