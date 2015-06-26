class CreateMods < ActiveRecord::Migration
  def change
    create_table :mods do |t|
      t.string :name
      t.string :order
      t.integer :track_id

      t.timestamps
    end
  end
end
