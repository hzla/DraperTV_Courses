class CreateBucketlists < ActiveRecord::Migration
  def change
    create_table :bucketlists do |t|

      t.timestamps
      t.integer :user_id
    end
  end
end
