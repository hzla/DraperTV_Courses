class Topic < ActiveRecord::Base
  attr_accessible :name, :percent_complete, :icon, :order, :percentage
  has_many :tracks

  def status
  end

  def percentage_complete
  	track_count = tracks.count
  	percent = tracks.map(&:percent_complete).inject(:+) / track_count.to_f
  	percent.floor   
  end

  def status
  	return "completed" if complete?
  	return "started" if started?
  	return "untouched"
  end

  def started?
  	percent_complete > 0
  end

  def complete?
  	percent_complete == 100
  end

  def done_icon
    done = icon.gsub(".svg", "badge.svg") 
  end

end
