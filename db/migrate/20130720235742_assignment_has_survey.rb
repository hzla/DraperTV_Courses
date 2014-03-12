class AssignmentHasSurvey < ActiveRecord::Migration
  def change
  	change_table :assignments do |t|
  		t.integer :survey_id
  	end
  end
end
