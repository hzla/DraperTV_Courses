class Lesson < ActiveRecord::Base
	belongs_to :mod
	has_many :comments
	attr_accessible :lesson_type, :mod_id, :started, :finished, :video, :video_uid, :video_title, :video_author, :body, :description, :discussion
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
			topic = mod.track.topic
			topic.update_attributes percent_complete: topic.percentage_complete 
		end
	end
end

