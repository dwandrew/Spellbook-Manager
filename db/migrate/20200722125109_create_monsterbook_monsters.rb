class CreateMonsterbookMonsters < ActiveRecord::Migration[4.2]
  def change
    create_table :monsterbook_monsters do |t|
      t.integer :monster_id
      t.integer :monsterbook_id
      

      t.timestamps null: false
    end
  end
end
