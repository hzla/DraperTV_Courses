class AddCompleteToBucketlistItem < ActiveRecord::Migration
  def change
    add_column :bucketlist_items, :complete, :boolean
  end
end
