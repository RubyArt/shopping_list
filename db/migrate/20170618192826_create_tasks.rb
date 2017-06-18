class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :group_id
      t.integer :creator_id
      t.integer :owner_id
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
