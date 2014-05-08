class AddCharPointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :char_points, :integer
  end
end
