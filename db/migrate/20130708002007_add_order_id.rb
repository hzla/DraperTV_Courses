class AddOrderId < ActiveRecord::Migration
  def change
  	add_column :assignments, :order_id, :integer
  end
end
