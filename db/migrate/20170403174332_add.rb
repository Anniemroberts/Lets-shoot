class Add < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_auth, :boolean, default: false
  end
end
