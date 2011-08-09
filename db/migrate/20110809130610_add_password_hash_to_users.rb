class AddPasswordHashToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :password_hash, :string
    remove_column :users, :password
  end

  def self.down
    remove_column :users, :password_hash
    add_column :users, :password, :string
  end
end
