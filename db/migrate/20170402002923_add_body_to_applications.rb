class AddBodyToApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :body, :text
  end
end
