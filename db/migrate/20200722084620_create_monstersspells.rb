class CreateMonstersspells < ActiveRecord::Migration[4.2]
  def change
    create_table :monsters_spells do |t|
      t.integer :monster_id
      t.integer :spell_id
    
      t.timestamps null: false
    end
  end
end
