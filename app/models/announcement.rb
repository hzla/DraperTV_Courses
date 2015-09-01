class Announcement < ActiveRecord::Base
  
  def self.today
  	where("created_at > (?)", Time.now - 24.hours).where(archived: nil).select {|n| n.created_at.day == (Time.now + 7.hours).day}
  end

  def self.date_today
  	(Time.now.utc - 7.hours).strftime("%B %-d, %Y")
  end

  def self.formatted_archived
  	Announcement.order('created_at desc').where(archived: true).group_by(&:date)
  end

  def date
  	(created_at.utc - 7.hours).strftime("%B %-d, %Y")
  end
end
