class AddAttachmentSpeakerPicToAssignments < ActiveRecord::Migration
  def self.up
    change_table :assignments do |t|
      t.attachment :speaker_pic
    end
  end

  def self.down
    drop_attached_file :assignments, :speaker_pic
  end
end
