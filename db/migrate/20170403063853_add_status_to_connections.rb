class AddStatusToConnections < ActiveRecord::Migration[5.0]
  def change
    add_column :connections, :phone, :string
    add_column :connections, :connection_id, :integer
    remove_column :connections, :friend_id
  end
end
