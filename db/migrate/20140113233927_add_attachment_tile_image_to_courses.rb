class AddAttachmentTileImageToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :tile_image
    end
  end

  def self.down
    drop_attached_file :courses, :tile_image
  end
end
