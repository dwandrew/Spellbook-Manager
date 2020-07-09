class SpellbookSpell < ActiveRecord::Base
    belongs_to :spellbook
    belongs_to :spell
    belongs_to :newspell
end
