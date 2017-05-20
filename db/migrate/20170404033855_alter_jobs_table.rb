class AlterJobsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :longitude, :float
    add_column :jobs, :latitude, :float
    add_column :jobs, :aasm_state, :string
    add_column :jobs, :address, :string
    remove_column :jobs, :location
  end
end
