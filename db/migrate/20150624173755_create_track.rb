class CreateTrack < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :order
      t.string :name
      t.string :icon
      t.string :percent_complete
      t.integer :topic_id
    end
  end
end
