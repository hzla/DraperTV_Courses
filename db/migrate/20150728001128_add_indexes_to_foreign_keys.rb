class AddIndexesToForeignKeys < ActiveRecord::Migration
  def change
  	add_index :comments, :user_id
  	add_index :comments, :ama_id
  	add_index :comments, :lesson_id
  	add_index :lessons, :track_id
  	add_index :progresses, :model_id
  	add_index :progresses, :user_id
  	add_index :tracks, :topic_id
  end
end
