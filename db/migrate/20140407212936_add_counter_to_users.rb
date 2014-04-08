class AddCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pCounter, :integer
    add_column :users, :bonus_credits, :integer
    add_column :users, :bonus_points_earned, :integer
  end
end
