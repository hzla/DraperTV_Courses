class AddAttachmentVideoPicToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :video_pic
    end
  end

  def self.down
    drop_attached_file :videos, :video_pic
  end
end
