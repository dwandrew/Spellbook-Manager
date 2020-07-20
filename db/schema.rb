# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_09_101905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "newspells", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "level"
    t.string "school"
    t.string "classes"
    t.string "range"
    t.string "components"
    t.string "material"
    t.boolean "ritual"
    t.boolean "concentration"
    t.string "duration"
    t.string "casting_time"
    t.string "desc"
    t.string "higher_level"
    t.integer "spellbook_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spellbook_spells", id: :serial, force: :cascade do |t|
    t.integer "spell_id"
    t.integer "spellbook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "newspell_id"
  end

  create_table "spellbooks", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "book_name"
    t.string "book_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spells", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.string "higher_level"
    t.string "range"
    t.string "components"
    t.string "material"
    t.boolean "ritual"
    t.boolean "concentration"
    t.string "duration"
    t.string "casting_time"
    t.string "level"
    t.string "school"
    t.string "classes"
    t.integer "spellbook_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
