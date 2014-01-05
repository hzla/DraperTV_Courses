class AddAttachmentSpeakerPicToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :speaker_pic
    end
  end

  def self.down
    drop_attached_file :videos, :speaker_pic
  end
end
