class AddNewspellsToSpellbookSpells < ActiveRecord::Migration
  def change
    add_column :spellbook_spells, :newspell_id, :integer
  end
end
