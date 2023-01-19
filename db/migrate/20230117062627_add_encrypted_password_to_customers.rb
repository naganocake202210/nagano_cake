class AddEncryptedPasswordToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :encrypted_password, :string, default: "", null: false
  end
end
