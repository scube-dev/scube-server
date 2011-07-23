class AddMimeTypeFieldToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :mime_type, :string
  end

  def self.down
    remove_column :tracks, :mime_type
  end
end
