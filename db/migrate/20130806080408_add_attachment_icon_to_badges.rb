class AddAttachmentIconToBadges < ActiveRecord::Migration
  def self.up
    change_table :badges do |t|
      t.attachment :icon
    end
  end

  def self.down
    drop_attached_file :badges, :icon
  end
end
