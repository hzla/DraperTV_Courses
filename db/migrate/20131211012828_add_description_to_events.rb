  class AddDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
    add_column :events, :location, :string
    add_column :events, :user_id, :integer
    add_index :events, :user_id
  end
end
