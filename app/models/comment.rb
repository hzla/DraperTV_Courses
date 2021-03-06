class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :lesson
	belongs_to :ama
	# make polymorphic?
	acts_as_votable
	
	after_create :sanitize_body
	
	has_ancestry

	def self_upvote
		if comment_type != "chat"
			liked_by user
			user.update_title_and_karma 1
		end
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

	def toggle_upvote_from voting_user
		if liked_by? voting_user
	      unliked_by voting_user
	      user.update_title_and_karma -1
	    else
	      liked_by voting_user
	      user.update_title_and_karma 1
	    end
	end

	def formatted_body
		return nil if body.nil?
		body.gsub("\n", "<br>")
	end

	private

	def sanitize_body
		update_attributes body: Sanitize.fragment(body, elements: ["br"])		
	end
end
