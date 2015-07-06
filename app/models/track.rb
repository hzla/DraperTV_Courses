class Track < ActiveRecord::Base
  attr_accessible :name, :percent_complete, :icon, :topic_id, :order
  belongs_to :topic
  has_many :lessons

  def percent_complete
  	total = lessons.count
  	complete = lessons.where(finished: true).count
  	percentage = complete / total.to_f * 100
  	percentage.floor
  end

  def started?
    percent_complete > 0
  end

  def complete?
    percent_complete == 100
  end

  def status
    return "completed" if percent_complete == 100
    return "started" if percent_complete > 0
    return "untouched"
  end

  def done_icon
    done = icon.gsub(".svg", "done.svg") 
  end

  def started_icon
    done = icon.gsub(".svg", "white.svg") 
  end



end
