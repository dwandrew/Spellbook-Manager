class CreateMonsters < ActiveRecord::Migration[4.2]
  def change
    create_table :monsters do |t|
            t.string :name
            t.string :monster_type
            t.string :monster_subtype, default: 'none'
            t.string :size
            t.string :alignment
            t.integer :armor_class
            t.integer :hit_points
            t.string :hit_dice
            t.string :challenge_rating
            t.string :speed
            t.string :other_speeds, default: 'none'
            t.integer :strength
            t.integer :dexterity
            t.integer :constitution
            t.integer :intelligence
            t.integer :wisdom
            t.integer :charisma
            t.string :proficiencies
            t.string :damage_vulnerabilities, default: "none"
            t.string :damage_resistences, default: "none"
            t.string :damage_immunities, default: "none"
            t.string :condition_immunities, default: "none"
            t.string :senses
            t.string :languages, default: "none"
            t.string :special_abilities, default: "none"
            t.string :actions, default: "none"
            t.string :reactions, default: "none"
            t.string :legendary_actions, default: "none"
            t.integer :monsterbook_id
            
      
      
            t.timestamps null: false
          end
        end
      end
