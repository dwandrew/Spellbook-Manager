class Monsterbook < ActiveRecord::Base
    belongs_to :user
    has_many :monsterbooks_monsters
    has_many :monsters, through: :monsterbooks_monsters

    validates :book_name, presence: true, uniqueness: true
end
