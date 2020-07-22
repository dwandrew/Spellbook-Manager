class Monstersspell < ActiveRecord::Base
    belongs_to :monster
    belongs_to :spell
    belongs_to :newmonster
end
