class AddSummaryToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :summary, :text
    add_column :tracks, :video_uid, :string
  end
end
