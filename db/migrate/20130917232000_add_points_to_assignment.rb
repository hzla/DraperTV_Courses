class AddPointsToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :points, :integer
  end
end
