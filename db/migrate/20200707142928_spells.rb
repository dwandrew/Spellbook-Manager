class Spells < ActiveRecord::Migration[4.2]
  def change
    create_table :spells do |t|
      t.string :name
      t.string :desc
      t.string :higher_level
      t.string :range
      t.string :components
      t.string :material
      t.boolean :ritual
      t.boolean :concentration
      t.string :duration
      t.string :casting_time
      t.string :level
      t.string :school
      t.string :classes
      t.integer :spellbook_id
    end
  end
end
