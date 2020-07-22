class CreateMonsterbooks < ActiveRecord::Migration[4.2]
  def change
    create_table :monsterbooks do |t|
      t.string :name
      t.integer :user_id
      t.string  :book_name

      t.timestamps null: false
    end
  end
end
