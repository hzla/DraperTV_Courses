class AddAttachmentUploadToUserAssignments < ActiveRecord::Migration
  def self.up
    change_table :user_assignments do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :user_assignments, :upload
  end
end
