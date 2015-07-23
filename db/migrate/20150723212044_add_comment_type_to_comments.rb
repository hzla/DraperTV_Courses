class AddCommentTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_type, :string, default: "regular"
  end
end
