class AddDayToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :day, :string
  end
end
