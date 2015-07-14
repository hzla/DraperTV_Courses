class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :model_id
      t.string :model_type
      t.integer :percent_complete
      t.integer :user_id

      t.timestamps
    end
  end
end
