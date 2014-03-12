class AddDetailsToUserAssignment < ActiveRecord::Migration
  def change
    change_column :user_assignments, :link, :string, :default => nil
  end
end
