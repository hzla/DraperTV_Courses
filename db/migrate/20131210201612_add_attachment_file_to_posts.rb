class AddAttachmentFileToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :posts, :file
  end
end
