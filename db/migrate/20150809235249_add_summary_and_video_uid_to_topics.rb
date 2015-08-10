class AddSummaryAndVideoUidToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :summary, :text
    add_column :topics, :video_uid, :string
  end
end
