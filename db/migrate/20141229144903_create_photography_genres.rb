class CreatePhotographyGenres < ActiveRecord::Migration
  def change
    create_table :photography_genres do |t|
      t.integer     :genre_id, null: false
      t.integer     :photography_id, null: false

      t.timestamps
    end
    add_index :photography_genres, :photography_id
  end
end
