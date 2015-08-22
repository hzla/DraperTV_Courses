class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :body
      t.boolean :archived
      t.timestamps
    end
  end
end
