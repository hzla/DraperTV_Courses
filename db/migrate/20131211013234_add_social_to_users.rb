class AddSocialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employment, :string
    add_column :users, :instagram, :string
    add_column :users, :angellist, :string
    add_column :users, :dribbble, :string
    add_column :users, :github, :string
  end
end
