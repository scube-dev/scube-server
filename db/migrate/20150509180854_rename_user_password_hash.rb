class RenameUserPasswordHash < ActiveRecord::Migration
  def change
    rename_column       :users, :password_hash, :password_digest
    change_column_null  :users, :password_digest, false
  end
end
