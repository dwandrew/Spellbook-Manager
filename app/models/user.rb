class User < ActiveRecord::Base
    has_secure_password
   
    has_many :spellbooks
    has_many :newspells
    has_many :monsterbooks

    validates :username, presence: true, uniqueness: true
end
