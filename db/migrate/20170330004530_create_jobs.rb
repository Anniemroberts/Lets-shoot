class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :when
      t.string :show
      t.boolean :tcp
      t.boolean :car

      t.timestamps
    end
  end
end
