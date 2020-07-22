class Spell < ActiveRecord::Base
    has_many :spellbook_spells
    has_many :spellbooks, through: :spellbook_spells
    has_many :monstersspells
    has_many :monsters, through: :monstersspells
end
