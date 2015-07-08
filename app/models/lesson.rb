class Lesson < ActiveRecord::Base
	belongs_to :track
	has_many :comments
	attr_accessible :order, :lesson_type, :track_id, :started, :finished, :video, :video_uid, :video_title, :video_author, :body, :description, :discussion
	after_update :update_topic_percentage

	def icon color=nil
		image = action_type + ".svg"
		if color == "grey"
			image.gsub!(".", "grey.")
		end
		image
	end

	def action_type
		if lesson_type == "watch"
			"watch"
		elsif lesson_type == "discussion" || lesson_type == "challenge"
			"do"
		else
			"read"
		end
	end

	def update_topic_percentage
		if finished_changed?
			topic = track.topic
			topic.update_attributes percent_complete: topic.percentage_complete 
		end
	end

	def status_icon
		if finished?
			"done.svg"
		else
			"untouched.svg"
		end
	end

	def next_lesson
		lesson_ids = track.lessons.order(:order).pluck(:id)
		next_lesson_id = lesson_ids[lesson_ids.index(id) + 1]
		if next_lesson_id
			Lesson.find next_lesson_id
		else
			self
		end
	end
end

