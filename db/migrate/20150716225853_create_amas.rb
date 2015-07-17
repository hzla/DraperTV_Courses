class CreateAmas < ActiveRecord::Migration
  def change
    create_table :amas do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.string :image_url
      t.string :video_url

      t.timestamps
    end
  end
end
