class AddAttachmentIntroScreenshotToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :intro_screenshot
    end
  end

  def self.down
    drop_attached_file :courses, :intro_screenshot
  end
end
