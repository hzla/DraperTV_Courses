class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
