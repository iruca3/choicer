class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer   :user_id, null: false
      t.integer   :value, null: false, default: 0
      t.integer   :photography_id, null: false

      t.timestamps
    end
    add_index :points, :photography_id
    add_index :points, [ :photography_id, :user_id ]
  end
end
