class AddDetailsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :experience, :text
    add_column :users, :dgc, :string
    add_column :users, :phone, :string
  end
end
