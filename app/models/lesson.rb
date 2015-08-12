class Lesson < ActiveRecord::Base
	belongs_to :track
	has_many :comments
	attr_accessible :video_length, :order, :lesson_type, :track_id, :started, :finished, :video, :video_uid, :video_title, :video_author, :body, :description, :discussion
	after_update :update_topic_percentage

	#put progress method into a progressable module

	def icon color=nil
		image = lesson_type + ".svg"
		if color == "grey"
			image.gsub!(".", "grey.")
		end
		image
	end

	def short_info number
		short_text = nil
		if lesson_type == "watch"
			short_text = "#{lesson_type.capitalize} - #{video_title}"
		elsif lesson_type == "reading"
			short_text = "#{lesson_type.capitalize} - #{body.split("http")[0]}"
		else
			short_text = "#{lesson_type.capitalize} #{number}"
		end
		short_text = short_text[0..59]
		short_text = short_text + "..." if short_text.length == 60
		short_text
	end


	def full_info
		full_text = "#{lesson_type.capitalize} #{description}"
	end

	def progress user
		return nil if !user
		Progress.where(model_type: "lesson", model_id: id, user_id: user.id).first
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

	def self.description_for lesson_type
		if lesson_type == "watch"
			"These are videos clips taken from actual Draper Univerisity lectures. You can learn about entrepreneurship directly from founders, VCs, execs, lawyers, and more.
			<br><br>We’ve cut them up into short, easy clips for you. If you’d like to access the full lectures you’ll need to upgrade to a Superhero Membership."
		elsif lesson_type == "challenge"
			"Learn by doing”. These are a list of activities that we’ve come up with to help you practice your entrepreneurial skills. Many of these are again, actual activities that we have students do at Draper Univeristy, designed to push you outside of your comfort zone.
			<br><br>Absolutely feel free to post your progress or results and share with students so we can give you feedback!"
		elsif lesson_type == "reading"
			"We’ve pulled together a collection of books and articles for you to supplement your learning. These are the same recommendations we give to students here at DU, we hope you find them just as helpful!"
		elsif lesson_type == "discussion"
			"We’ve come up with some discussion questions and topics to help you start thinking in the right direction about startups.
			<br><br>Share your ideas and thoughts with other students. Keep an eye out for Draper U Alumni, mentors, and staff! We’ll come on regularly to give feedback, and share our own insights."
		else
			"Starting a company is hard enough on your own, everyone needs a little help. These are tools and servies already built by other entrepreneurs we think would help you get closer to your goals.
			<br><br>We’ve tried to mostly find free to use tools, but some software may require a purchase. "
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

