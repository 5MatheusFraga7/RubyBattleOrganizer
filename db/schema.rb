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

ActiveRecord::Schema.define(version: 20220217154649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battle_fields", force: :cascade do |t|
    t.integer  "dungeon_master_id"
    t.string   "title"
    t.string   "background_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["dungeon_master_id"], name: "index_battle_fields_on_dungeon_master_id", using: :btree
  end

  create_table "dm_monsters", force: :cascade do |t|
    t.integer  "dungeon_master_id"
    t.string   "name"
    t.string   "profile_picture_url"
    t.integer  "health_points"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["dungeon_master_id"], name: "index_dm_monsters_on_dungeon_master_id", using: :btree
  end

  create_table "dungeon_masters", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "profile_picture_url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_dungeon_masters_on_user_id", using: :btree
  end

  create_table "monster_battle_fields", force: :cascade do |t|
    t.integer  "battle_field_id"
    t.integer  "dm_monster_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["battle_field_id"], name: "index_monster_battle_fields_on_battle_field_id", using: :btree
    t.index ["dm_monster_id"], name: "index_monster_battle_fields_on_dm_monster_id", using: :btree
  end

  create_table "player_battle_fields", force: :cascade do |t|
    t.integer  "battle_field_id"
    t.integer  "player_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["battle_field_id"], name: "index_player_battle_fields_on_battle_field_id", using: :btree
    t.index ["player_id"], name: "index_player_battle_fields_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "profile_picture_url"
    t.integer  "dungeon_master_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["dungeon_master_id"], name: "index_players_on_dungeon_master_id", using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "type_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "battle_fields", "dungeon_masters"
  add_foreign_key "dm_monsters", "dungeon_masters"
  add_foreign_key "dungeon_masters", "users"
  add_foreign_key "monster_battle_fields", "battle_fields"
  add_foreign_key "monster_battle_fields", "dm_monsters"
  add_foreign_key "player_battle_fields", "battle_fields"
  add_foreign_key "player_battle_fields", "players"
  add_foreign_key "players", "dungeon_masters"
  add_foreign_key "players", "users"
  add_foreign_key "users", "roles"
end
