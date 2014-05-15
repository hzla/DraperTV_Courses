class AddCompleteToUserAssignment < ActiveRecord::Migration
  def change
    add_column :user_assignments, :complete, :boolean, default: false
  end
end
