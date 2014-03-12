class ChangeUserIdToInteger < ActiveRecord::Migration
  def change
  	remove_column :user_assignments, :user_id
  end
end
