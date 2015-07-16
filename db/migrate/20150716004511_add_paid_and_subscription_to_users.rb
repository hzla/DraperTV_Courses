class AddPaidAndSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paid, :boolean, default: false
    add_column :users, :subscription, :string
    add_column :users, :customer_id, :string
  end
end
