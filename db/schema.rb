# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_18_094145) do
  create_table "monsterbook_monsters", force: :cascade do |t|
    t.integer "monster_id"
    t.integer "monsterbook_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "monsterbooks", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "book_name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
    t.string "monster_type"
    t.string "monster_subtype", default: "none"
    t.string "size"
    t.string "alignment"
    t.integer "armor_class"
    t.integer "hit_points"
    t.string "hit_dice"
    t.string "challenge_rating"
    t.string "speed"
    t.string "other_speeds", default: "none"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string "proficiencies"
    t.string "damage_vulnerabilities", default: "none"
    t.string "damage_resistences", default: "none"
    t.string "damage_immunities", default: "none"
    t.string "condition_immunities", default: "none"
    t.string "senses"
    t.string "languages", default: "none"
    t.string "special_abilities", default: "none"
    t.string "actions", default: "none"
    t.string "reactions", default: "none"
    t.string "legendary_actions", default: "none"
    t.integer "monsterbook_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "image", default: "none"
  end

  create_table "monstersspells", force: :cascade do |t|
    t.integer "monster_id"
    t.integer "spell_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "newspells", force: :cascade do |t|
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spellbook_spells", force: :cascade do |t|
    t.integer "spell_id"
    t.integer "spellbook_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "newspell_id"
  end

  create_table "spellbooks", force: :cascade do |t|
    t.integer "user_id"
    t.string "book_name"
    t.string "book_class"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spells", force: :cascade do |t|
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

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

end
