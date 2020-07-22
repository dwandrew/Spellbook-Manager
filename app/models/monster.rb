class Monster < ActiveRecord::Base
    has_many :monsterbook_monsters
    has_many :monsterbooks, through: :monsterbook_monsters
    has_many :monstersspells
    has_many :spells, through: :monstersspells
   
end