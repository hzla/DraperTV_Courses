class AddAttachmentPhotoToApps < ActiveRecord::Migration
  def self.up
    change_table :apps do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :apps, :photo
  end
end
