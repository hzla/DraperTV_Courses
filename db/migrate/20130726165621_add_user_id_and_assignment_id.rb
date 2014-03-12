class AddUserIdAndAssignmentId < ActiveRecord::Migration
  def change
  	add_column :user_assignments, :user_id, :integer
  	add_column :user_assignments, :assignment_id, :integer
  end
end
