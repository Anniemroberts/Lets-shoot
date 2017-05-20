class AddStateToApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :aasm_state, :string
  end
end
