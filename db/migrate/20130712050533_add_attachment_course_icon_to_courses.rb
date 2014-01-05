class AddAttachmentCourseIconToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :course_icon
    end
  end

  def self.down
    drop_attached_file :courses, :course_icon
  end
end
