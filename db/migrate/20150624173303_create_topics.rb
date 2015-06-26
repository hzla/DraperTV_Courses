class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :icon
      t.string :name
      t.integer :percent_complete
      t.integer :order
    end
  end
end
