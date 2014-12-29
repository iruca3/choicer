class ChangeIndexForPoints < ActiveRecord::Migration
  def change
    remove_index :points, [ :photography_id, :user_id ]
    add_index :points, [ :user_id, :photography_id ], unique: true
  end
end
