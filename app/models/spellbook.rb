class Spellbook < ActiveRecord::Base
    belongs_to :user
    has_many :spellbook_spells
    has_many :spells, through: :spellbook_spells
    has_many :newspells, through: :spellbook_spells

    validates :book_name, presence: true, uniqueness: true
end
