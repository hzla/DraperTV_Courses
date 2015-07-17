class AddAmaIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ama_id, :integer
  end
end
