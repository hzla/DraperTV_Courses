class AddShowTopicTutorialAndShowTrackTutorialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_topic_tutorial, :boolean, default: true
    add_column :users, :show_track_tutorial, :boolean, default: true
  end
end
