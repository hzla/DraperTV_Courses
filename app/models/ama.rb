class Ama < ActiveRecord::Base
	has_many :comments

	def self.upcoming 
		amas = Ama.where('start_date > (?)', Time.now)
	end

  def is_past?
    start_date < Time.now
  end

  def is_upcoming?
    start_date > Time.now 
  end

	def self.past
		amas = Ama.where('start_date < (?)', Time.now)
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
        pst_start_date.strftime("Today at %-l:%M %P PST")
      end
  	elsif start_date - Time.now < 48.hours && pst_start_date.to_date === (pst_current_time + 1.day).to_date
  		pst_start_date.strftime("Tomorrow at %-l:%M %P PST")
  	elsif start_date > Time.now
      (start_date - 7.hours).strftime("%-l:%M%P PST - %B %-d, %Y")
    else
  		days_ago = (Time.now - pst_start_date) / 86400
      if pst_start_date.to_date === (pst_current_time - 1.day).to_date
        pst_start_date.strftime("1 day ago")
      else
        pst_start_date.strftime("#{days_ago.floor} days ago")  
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
