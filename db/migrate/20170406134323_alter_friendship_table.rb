class AlterFriendshipTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :friendships, :user
    remove_column :friendships, :friend
    add_column :friendships, :user_id, :integer
    add_column :friendships, :friend_id, :integer
  end
end
