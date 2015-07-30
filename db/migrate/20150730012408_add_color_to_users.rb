class AddColorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :color, :string, default: '#414141'
  end
end
