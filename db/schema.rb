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

ActiveRecord::Schema.define(version: 20170723191003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ballots", force: :cascade do |t|
    t.bigint "contestant1_id", null: false
    t.bigint "contestant2_id", null: false
    t.integer "contestant1_votes", default: 0, null: false
    t.integer "contestant2_votes", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant1_id"], name: "index_ballots_on_contestant1_id"
    t.index ["contestant2_id"], name: "index_ballots_on_contestant2_id"
  end

  create_table "contestants", force: :cascade do |t|
    t.string "name", null: false
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
