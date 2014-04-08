class AddPointsToUserAssignments < ActiveRecord::Migration
  def change
    add_column :user_assignments, :point_value, :integer
    add_column :user_assignments, :bonus_points_given, :integer
  end
end
