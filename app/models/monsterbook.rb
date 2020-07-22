class Monsterbook < ActiveRecord::Base
    belongs_to :user
    has_many :monsterbook_monsters
    has_many :monsters, through: :monsterbook_monsters

    validates :book_name, presence: true, uniqueness: true
end
