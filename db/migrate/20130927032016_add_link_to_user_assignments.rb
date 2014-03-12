class AddLinkToUserAssignments < ActiveRecord::Migration
  def change
    add_column :user_assignments, :link, :string
  end
end
