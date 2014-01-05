class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :vimeo_url
      t.string :preview_url
      t.integer :order_id
      t.string :speaker_name
      t.text :speaker_bio
      t.string :speaker_linkedin
      t.string :speaker_twitter
      t.string :speaker_angel
      t.string :category
      t.string :slug

      t.timestamps
    end
  end
end
