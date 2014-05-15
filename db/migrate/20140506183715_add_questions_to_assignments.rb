class AddQuestionsToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :question_text, :string
    add_column :assignments, :question_duh_response, :text
    add_column :assignments, :active, :boolean
    add_column :assignments, :business, :boolean
  end
end
