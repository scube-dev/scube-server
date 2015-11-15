class CreateReleaseTracks < ActiveRecord::Migration
  def change
    create_table :release_tracks do |t|
      t.timestamps null: false

      t.references :release, index: true, foreign_key: true, null: false
      t.references :track, index: true, foreign_key: true, null: false

      t.integer :number, null: false

      t.index %i[release_id track_id number], unique: true
    end
  end
end
