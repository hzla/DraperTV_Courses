class AddItemsToBucketlistItem < ActiveRecord::Migration
  def change
    add_column :bucketlist_items, :title, :string
    add_column :bucketlist_items, :body, :text
  end
end
