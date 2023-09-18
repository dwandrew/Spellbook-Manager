class AddImageToMonsters < ActiveRecord::Migration[4.2]
  def change
    change_table :monsters do |t|
      t.change :image, :string, default: 'none'
    end
  end
end
