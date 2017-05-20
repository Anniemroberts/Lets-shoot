class AddEncryptedPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
    end
  end
end
