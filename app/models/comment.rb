class Comment < ActiveRecord::Base
	attr_accessible :user_id, :lesson_id, :body, :ama_id, :parent, :parent_id
	belongs_to :user
	belongs_to :lesson
	belongs_to :ama
	acts_as_votable
	after_create :self_upvote
	has_ancestry


	def self_upvote
		liked_by user
		user.update_title_and_karma
	end

	def elapsed_time
	    elapsed_time_in_minutes = (Time.now - created_at) / 60
	    elapsed_time_in_hours = nil
	    stamp = nil
	    if elapsed_time_in_minutes.floor < 60
	      stamp = "#{elapsed_time_in_minutes.floor} minutes ago"
	    elsif elapsed_time_in_minutes < 1440
	      elapsed_time_in_hours = (elapsed_time_in_minutes / 60).floor
	      stamp = "#{elapsed_time_in_hours} hours ago"
	    elsif elapsed_time_in_minutes > 1440 && elapsed_time_in_minutes < 43200
	    	elapsed_time_in_days = (elapsed_time_in_minutes / 1440).floor
	    	stamp = "#{elapsed_time_in_days} #{elapsed_time_in_days > 1 ? 'days' : 'day'} ago"
	    else
	      stamp = created_at.strftime("%b %-d %Y")
	    end
	end

	def liked_by? user
		!ActsAsVotable::Vote.where(votable_id: id, voter_id: user.id).empty?
	end
end
