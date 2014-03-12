class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.string :vimeo_url
      t.string :preview_url

      t.timestamps
    end
  end
end
