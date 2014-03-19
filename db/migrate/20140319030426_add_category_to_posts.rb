class AddCategoryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :category, :string
    add_column :posts, :privacy, :string
  end
end
