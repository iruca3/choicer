class CreateUserGenreRankings < ActiveRecord::Migration
  def change
    create_table :user_genre_rankings do |t|
      t.integer   :user_id, null: false
      t.integer   :genre_id, null: false

      t.timestamps
    end
  end
end
