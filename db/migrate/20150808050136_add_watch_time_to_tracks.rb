class AddWatchTimeToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :watch_time, :integer
  end
end
