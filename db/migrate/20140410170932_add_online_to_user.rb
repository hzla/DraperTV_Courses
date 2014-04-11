class AddOnlineToUser < ActiveRecord::Migration
  def change
    add_column :users, :online, :string
  end
end
