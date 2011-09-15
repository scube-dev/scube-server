class CreateSounds < ActiveRecord::Migration
  def up
    create_table :sounds do |t|
      t.integer :track_id
      t.string  :sha256
      t.string  :mime_type

      t.timestamps
    end
  end

  def down
    drop_table :sounds
  end
end
