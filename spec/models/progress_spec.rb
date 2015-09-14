require 'spec_helper'

describe Progress do 
	before :each do 
		@user = create :user
		@topic = create :topic
		@track = create :track, topic_id: @topic.id
		@lesson1 = create :lesson, track_id: @track.id
		@lesson2 = create :lesson, track_id: @track.id
	end

	describe '#update_percentage_for_parent_progresses' do 

		it "updates a parent progress percentage based on progress percentage on completed lessons" do 
			Lesson::ActiveRecord_Associations_CollectionProxy.any_instance.stubs(:where).returns([@lesson1, @lesson2])
			lesson_progress = create :progress, model_type: "lesson", model_id: @lesson1.id, user_id: @user.id, percent_complete: 100
			lesson_progress.update_percentage_for_parent_progresses @user
			expect(@track.progress_percentage(@user)).to eq 50
			expect(@topic.progress_percentage(@user)).to eq 50
		end
	end
end