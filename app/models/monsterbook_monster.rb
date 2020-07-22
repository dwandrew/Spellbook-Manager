class MonsterbookMonster < ActiveRecord::Base
    belongs_to :monster
    belongs_to :monsterbook
    belongs_to :newmonster
end
