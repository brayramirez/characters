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

ActiveRecord::Schema.define(version: 2018_06_08_080051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "status", default: 0, null: false
    t.boolean "commander", default: false, null: false
    t.boolean "false_commander", default: false, null: false
    t.boolean "bodyguard", default: false, null: false
    t.boolean "blind_spy", default: false, null: false
    t.boolean "deep_cover", default: false, null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_games_on_host_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "game_id"
    t.boolean "opposition", default: false
    t.integer "character"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_participants_on_game_id"
    t.index ["player_id", "game_id"], name: "index_participants_on_player_id_and_game_id", unique: true
    t.index ["player_id"], name: "index_participants_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "players", column: "host_id"
  add_foreign_key "participants", "games"
  add_foreign_key "participants", "players"
end
