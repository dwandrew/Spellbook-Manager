class Spellbook < ActiveRecord::Base
    belongs_to :user
    has_many :spells

end
