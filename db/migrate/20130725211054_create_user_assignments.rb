class CreateUserAssignments < ActiveRecord::Migration
  def change
    create_table :user_assignments do |t|
      t.string :user_id
      t.text :text
      t.string :assignment_id

      t.timestamps
    end
  end
end
