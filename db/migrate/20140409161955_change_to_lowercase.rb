class ChangeToLowercase < ActiveRecord::Migration
  def change
    rename_column :users, :nCounter, :ncounter
    rename_column :users, :pCounter, :pcounter
  end
end
