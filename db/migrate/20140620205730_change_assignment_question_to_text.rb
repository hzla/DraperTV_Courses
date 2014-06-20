class ChangeAssignmentQuestionToText < ActiveRecord::Migration
  def change
    change_column :assignments, :question_text, :text
  end
end
