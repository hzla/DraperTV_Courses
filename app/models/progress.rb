class Progress < ActiveRecord::Base
	belongs_to :user

	#use ancestry for faster access to children progresses

	def update_percentage_for_parent_progresses user
		if model_type == "lesson"
			Progress.where(model_type: "track", model_id: lesson.track.id, user_id: user.id).first_or_create.update_percentage_for_parent_progresses user
		elsif model_type == "track"
			lessons = track.lessons.where.not(lesson_type: "tools")
			lesson_progresses = lessons.map {|l| l.progress(user) }.compact
			update_attributes percent_complete: (lesson_progresses.count / lessons.count.to_f ) * 100
			Progress.where(model_type: "topic", model_id: track.topic.id, user_id: user.id).first_or_create.update_percentage_for_parent_progresses user
		else model_type == "topic"
			tracks = topic.tracks
			track_progresses = tracks.map {|t| t.progress_percentage(user) }.inject(:+)
			update_attributes percent_complete: (track_progresses / tracks.count.to_f ).floor 
		end
	end

	private

	def track
		Track.find model_id
	end

	def topic
		Topic.find model_id
	end

	def lesson
		Lesson.find model_id
	end
end
