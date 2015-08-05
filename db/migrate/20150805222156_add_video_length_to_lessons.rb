class AddVideoLengthToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :video_length, :string
  end
end
