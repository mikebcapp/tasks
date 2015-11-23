class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :importance
      t.datetime :due
      t.string :status
      t.timestamps
      t.integer :user_id
    end
  end
end
