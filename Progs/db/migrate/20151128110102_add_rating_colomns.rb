class AddRatingColomns < ActiveRecord::Migration
  def change

    add_column :users, :wins, :integer, default: 0
    add_column :users, :loss, :integer, default: 0
    add_column :users, :draw, :integer, default: 0


  end
end
