class AddNotificationCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nCounter, :integer
  end
end
