class InitialSchema < ActiveRecord::Migration
  def up

    create_table :playlists do |t|
      t.integer  :user_id
      t.string   :name

      t.timestamps
    end

    create_table :sessions do |t|
      t.string   :session_id, null: false
      t.text     :data

      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at

    create_table :tracks do |t|
      t.string   :name

      t.timestamps
    end

    create_table :users do |t|
      t.string   :email
      t.string   :password_hash

      t.timestamps
    end

    add_index :users, :email, unique: true

  end

  def down
    drop_index :sessions, :session_id
    drop_index :sessions, :updated_at
    drop_index :users, :email

    drop_table :playlists
    drop_table :sessions
    drop_table :tracks
    drop_table :users
  end
end
