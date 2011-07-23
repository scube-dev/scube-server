class AddSha256FieldToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :sha256, :string
  end

  def self.down
    remove_column :tracks, :sha256
  end
end
