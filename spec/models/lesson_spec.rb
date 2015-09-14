require 'spec_helper'

describe Lesson do 

	describe "lesson#icon" do 
		it "outputs the lesson_type and input color in the image name" do 
			lesson = create :lesson, lesson_type: "watch"
			expect(lesson.icon("grey")).to eq "icons/watchgrey.svg"
		end
	end

	describe "lesson#next_lesson" do 
		before :each do
			@topic = create :topic 
			@track = create :track, order: 1, topic_id: @topic.id 
			@lesson1 = create :lesson, track_id: @track.id
			@lesson2 = create :lesson, track_id: @track.id
			Track.any_instance.stubs(:ordered_lessons).returns [@lesson1, @lesson2]
		end

		it "returns the next lesson within the same track if there is one" do 
			expect(@lesson1.next_lesson).to eq @lesson2
		end

		it "returns the first lesson of the next track if there are no more lessons in the current track" do 
			@track2 = create :track, order: 2, topic_id: @topic.id
			expect(@lesson2.next_lesson).to eq @lesson1
		end

		it "returns the lesson topic if there are no more lessons and no more tracks" do 
			expect(@lesson2.next_lesson).to eq(@topic)
		end
	end
end