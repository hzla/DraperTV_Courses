class AddDefaultOrderId < ActiveRecord::Migration
  def change
  	change_column :assignments, :order_id, :integer, :default => 0
  end
end
