class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.integer :imdbID
      t.string :title
      t.string :overview
      t.string :poster_path
      t.string :backdrop_path
      t.float :vote_average
      t.date :release_date

      t.timestamps
    end
  end
end
