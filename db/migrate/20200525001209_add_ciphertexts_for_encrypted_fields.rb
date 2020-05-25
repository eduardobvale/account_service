class AddCiphertextsForEncryptedFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :name
    remove_column :accounts, :email
    remove_column :accounts, :cpf
    remove_column :accounts, :birth_date

    add_column :accounts, :name_ciphertext, :text
    add_column :accounts, :email_ciphertext, :text
    add_column :accounts, :cpf_ciphertext, :text
    add_column :accounts, :birth_date_ciphertext, :text

    add_column :accounts, :cpf_bidx, :string
    add_index :accounts, :cpf_bidx, unique: true
  end
end
