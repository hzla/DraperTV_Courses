class AddColumnToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :req_online, :string
    add_column :assignments, :req_boarding, :string
  end
end
