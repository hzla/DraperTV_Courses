class DropAssignmentId < ActiveRecord::Migration
  def change
  	remove_column :user_assignments, :assignment_id
  end
end
