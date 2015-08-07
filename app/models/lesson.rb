class Lesson < ActiveRecord::Base
	belongs_to :track
	has_many :comments
	attr_accessible :video_length, :order, :lesson_type, :track_id, :started, :finished, :video, :video_uid, :video_title, :video_author, :body, :description, :discussion
	after_update :update_topic_percentage

	#put progress method into a progressable module

	def icon color=nil
		image = action_type + ".svg"
		if color == "grey"
			image.gsub!(".", "grey.")
		end
		image
	end

	def progress user
		return nil if !user
		Progress.where(model_type: "lesson", model_id: id, user_id: user.id).first
	end

	def action_type
		if lesson_type == "watch"
			"watch"
		elsif lesson_type == "discussion" || lesson_type == "challenge"
			"do"
		elsif lesson_type == "reading"
			"read"
		else
			"tools"
		end
	end

	def update_topic_percentage
		if finished_changed?
			topic = track.topic
			topic.update_attributes percent_complete: topic.percentage_complete 
		end
	end

	def status_icon user
		return "untouched.svg" if !user
		if progress(user) && progress(user).percent_complete == 100
			"done.svg"
		else
			"untouched.svg"
		end
	end

	def next_lesson
		lesson_ids = track.ordered_lessons.map(&:id)
		next_lesson_id = lesson_ids[lesson_ids.index(id) + 1]
		if next_lesson_id
			Lesson.find next_lesson_id
		else
			next_track = track.topic.tracks.where(order: track.order + 1).first
			if next_track
				next_track.ordered_lessons.first
			else
				track.topic
			end
		end
	end

	def completed? user
		return nil if !user
		progress(user).percent_complete == 100
	end

	def complete user
		return nil if !user
		user_progress = progress(user)
		if user_progress.percent_complete != 100
			user_progress.update_attributes(percent_complete: 100)
			user_progress.update_percentage_for_parent_progresses user
		end
		self
	end

	def self.assign_order
		Track.all.each do |track|
			track.ordered_lessons.each_with_index do |lesson, i|
				lesson.update_attributes order: i
			end
		end
	end

	def participants
		User.find Progress.where(model_id: id).pluck(:user_id)
	end
end

