class Track < ActiveRecord::Base
  attr_accessible :name, :percent_complete, :icon, :topic_id, :order
  belongs_to :topic
  has_many :mods

  def percent_complete
  	total = mods.includes(:lessons).map(&:lessons).flatten.length
  	mod_ids = mods.pluck(:id)
  	complete = Lesson.where('mod_id in (?)', mod_ids).where(finished: true).count
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



end
