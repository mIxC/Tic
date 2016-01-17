class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.belongs_to :first_user
      t.belongs_to :second_user
      t.boolean :ending, default: false


      t.timestamps null: false
    end
  end
end
