class CreateSpellbookSpells < ActiveRecord::Migration
  def change
    create_table :spellbook_spells do |t|
      t.integer :spell_id
      t.integer :spellbook_id

      t.timestamps null: false
    end
  end
end
