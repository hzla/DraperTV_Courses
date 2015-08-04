class Ama < ActiveRecord::Base
	has_many :comments

	def self.upcoming
		Ama.where('start_date > (?)', Time.now)
	end

	def self.past
		Ama.where('start_date < (?)', Time.now)
	end

	def elapsed_time
    	elapsed_time_in_minutes = (Time.now - start_date) / 60
	    stamp = nil
	    if elapsed_time_in_minutes.floor < 60
	      stamp = "#{elapsed_time_in_minutes.floor} minutes ago"
	    elsif elapsed_time_in_minutes < 1440
	      elapsed_time_in_hours = (elapsed_time_in_minutes / 60).floor
	      stamp = "#{elapsed_time_in_hours} hours ago"
	    else
	      stamp = "#{start_date.strftime("%b %-d")}"
	    end
	end


  def formatted_start_date
  	pst_start_date = start_date - 7.hours
  	pst_current_time = Time.now.utc - 7.hours
  	if start_date - Time.now < 24.hours && pst_start_date.day == pst_current_time.day
      if start_date < Time.now
        elapsed_time
      else
        pst_start_date.strftime("Today at %l:%M %P PST")
      end
  	elsif start_date - Time.now < 48.hours && pst_start_date.day == pst_current_time.day + 1
  		pst_start_date.strftime("Tomorrow at %l:%M %P PST")
  	elsif start_date - Time.now < 48.hours && start_date > Time.now
      (start_date - 7.hours).strftime("%B %-d, at %l:%M%P PST")
    elsif start_date - Time.now > 48.hours && start_date > Time.now
      (start_date - 7.hours).strftime("%B %-d, at %l:%M%P PST")
    else
  		days_ago = (Time.now - pst_start_date) / 86400
      if days_ago.floor > 1
        pst_start_date.strftime("#{days_ago.floor} days ago")
      else
        pst_start_date.strftime("#{days_ago.floor} day ago")
      end
  	end
  end

  def regular_comments
    comments.includes(:user).where(ancestry: nil, comment_type: "regular").order('created_at desc')
  end

  def chat_comments
    comments.includes(:user).where(comment_type: "chat").order(:created_at)
  end
end
