class AddSkypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :skype, :string
    add_column :users, :gmail, :string
  end
end
