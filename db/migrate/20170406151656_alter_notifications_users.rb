class AlterNotificationsUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :user_id
    add_column :notifications, :actor_id, :integer
  end
end
