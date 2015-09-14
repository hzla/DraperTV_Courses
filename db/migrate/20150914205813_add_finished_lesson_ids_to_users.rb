class AddFinishedLessonIdsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :finished_lesson_ids, :integer, :array => true
  end
end
