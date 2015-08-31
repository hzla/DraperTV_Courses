class AddColorAndUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :color, :string
    add_column :events, :url, :string
  end
end
