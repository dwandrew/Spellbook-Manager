class CreateNewspells < ActiveRecord::Migration
  def change
    create_table :newspells do |t|
      
      t.string :name
      t.string :level
      t.string :school
      t.string :classes
      t.string :range
      t.string :components
      t.string :material
      t.boolean :ritual
      t.boolean :concentration
      t.string :duration
      t.string :casting_time
      t.string :desc
      t.string :higher_level
      t.integer :spellbook_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
