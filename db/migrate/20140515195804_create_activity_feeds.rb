class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.belongs_to :user, index: true
      t.string :action
      t.belongs_to :tobetrackable, index: true
      t.string :tobetrackable_type

      t.timestamps
    end
  end
end
