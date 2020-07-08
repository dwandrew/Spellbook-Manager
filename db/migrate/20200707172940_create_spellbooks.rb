class CreateSpellbooks < ActiveRecord::Migration
  def change
    create_table :spellbooks do |t|
      t.integer :user_id
      t.string :book_name
      t.string :book_class

      t.timestamps null: false
    end
  end
end
