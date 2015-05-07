class DropSessions < ActiveRecord::Migration
  def up
    drop_table :sessions
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
