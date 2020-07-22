class Monster < ActiveRecord::Base
    has_many :monsterbooks_monsters
    has_many :monsterbooks, through: :monsterbooks_monsters
    has_many :spells, through :monsters_spells
end