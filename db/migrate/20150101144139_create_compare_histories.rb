class CreateCompareHistories < ActiveRecord::Migration
  def change
    create_table :compare_histories do |t|
      t.integer      :user_id, null: false
      t.integer      :photography1_id, null: false
      t.integer      :photography2_id, null: false
      t.integer      :selected_photography_id, null: false

      t.timestamps
    end
  end
end
