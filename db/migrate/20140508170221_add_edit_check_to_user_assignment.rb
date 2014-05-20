class AddEditCheckToUserAssignment < ActiveRecord::Migration
  def change
    add_column :user_assignments, :editcheck, :boolean
  end
end
