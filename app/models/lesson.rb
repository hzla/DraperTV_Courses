class Lesson < ActiveRecord::Base
	belongs_to :track
	has_many :comments
	attr_accessible :order, :lesson_type, :track_id, :started, :finished, :video, :video_uid, :video_title, :video_author, :body, :description, :discussion
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

	def status_icon user
		return "untouched.svg" if !user
		if progress user
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
			self
		end
	end

	def completed? user
		return nil if !user
		progress user
	end

	def complete user
		return nil if !user
		if !progress user
			Progress.create(percent_complete: 100, user_id: user.id, model_type: "lesson", model_id: id).update_percentage_for_parent_progresses user
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
end

