class AddUniqueIndexes < ActiveRecord::Migration
  def change
    add_index :authors, :name,    unique: true
    add_index :sounds,  :sha256,  unique: true
  end
end
