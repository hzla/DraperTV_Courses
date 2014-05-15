class AddQuestionToUserAssignment < ActiveRecord::Migration
  def change
    add_column :user_assignments, :rating, :integer
    add_column :user_assignments, :question_response, :text
  end
end
