class AddNewspellsToSpellbookSpells < ActiveRecord::Migration[4.2]
  def change
    add_column :spellbook_spells, :newspell_id, :integer
  end
end
