class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string       :sns_id
      t.string       :provider

      t.timestamps
    end
    add_index :users, [ :sns_id, :provider ], unique: true
  end
end
