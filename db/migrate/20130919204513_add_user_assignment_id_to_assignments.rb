class AddUserAssignmentIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :user_assignment_id, :integer
  end
end
