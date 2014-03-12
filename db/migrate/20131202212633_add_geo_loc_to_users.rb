class AddGeoLocToUsers < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :float, :default => 37.5638
    add_column :users, :longitude, :float, :default => -122.325192
  end
end
