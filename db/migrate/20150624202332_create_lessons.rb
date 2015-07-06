class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :lesson_type
      t.boolean :video
      t.boolean :started, default: false
      t.boolean :finished, default: false
      t.string :video_uid
      t.string :video_title
      t.string :video_author
      t.text :body
      t.boolean :discussion
      t.text :description
      t.integer :mod_id

      t.timestamps
    end
  end
end
