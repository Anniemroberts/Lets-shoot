class FixConnectionsMistake < ActiveRecord::Migration[5.0]
  def change
    add_column :connections, :status, :string
    remove_column :connections, :phone
  end
end
