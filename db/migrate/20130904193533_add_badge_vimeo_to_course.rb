class AddBadgeVimeoToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :badge_vimeo, :string
  end
end
