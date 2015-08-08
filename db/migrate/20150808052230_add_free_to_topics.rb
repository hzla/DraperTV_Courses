class AddFreeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :free, :boolean, default: false
  end
end
