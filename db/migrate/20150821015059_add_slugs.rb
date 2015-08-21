class AddSlugs < ActiveRecord::Migration
  def change
  	add_column :topics, :slug, :string
  	add_column :tracks, :slug, :string
  	add_column :lessons, :slug, :string
  end
end
