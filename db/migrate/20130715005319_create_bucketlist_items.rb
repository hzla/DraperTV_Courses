class CreateBucketlistItems < ActiveRecord::Migration
  def change
    create_table :bucketlist_items do |t|

      t.timestamps
      t.integer :user_id
      t.integer :bucketlist_id
    end
  end
end
