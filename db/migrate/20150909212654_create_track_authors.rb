class CreateTrackAuthors < ActiveRecord::Migration
  def change
    create_table :track_authors do |t|
      t.timestamps null: false

      t.references :track, index: true, foreign_key: true, null: false
      t.references :author, index: true, foreign_key: true, null: false

      t.index %i[track_id author_id], unique: true
    end
  end
end
