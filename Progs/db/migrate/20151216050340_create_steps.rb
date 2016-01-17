class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.belongs_to :room
      t.boolean :is_cross
      t.belongs_to :user
      t.integer :position



      t.timestamps null: false
    end
  end
end
