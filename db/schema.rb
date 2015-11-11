# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151111083254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  add_index "authors", ["name"], name: "index_authors_on_name", unique: true, using: :btree

  create_table "keys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.string   "name"
    t.string   "token"
  end

  add_index "keys", ["token"], name: "index_keys_on_token", unique: true, using: :btree
  add_index "keys", ["user_id"], name: "index_keys_on_user_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sounds", force: :cascade do |t|
    t.integer  "track_id"
    t.string   "sha256"
    t.string   "mime_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sounds", ["sha256"], name: "index_sounds_on_sha256", unique: true, using: :btree

  create_table "track_authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "track_id",   null: false
    t.integer  "author_id",  null: false
  end

  add_index "track_authors", ["author_id"], name: "index_track_authors_on_author_id", using: :btree
  add_index "track_authors", ["track_id", "author_id"], name: "index_track_authors_on_track_id_and_author_id", unique: true, using: :btree
  add_index "track_authors", ["track_id"], name: "index_track_authors_on_track_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "keys", "users"
  add_foreign_key "track_authors", "authors"
  add_foreign_key "track_authors", "tracks"
end
