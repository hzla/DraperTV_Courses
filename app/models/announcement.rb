class Announcement < ActiveRecord::Base
  
  def self.today
  	where("created_at > (?)", Time.now - 24.hours).where(archived: nil).select {|n| (n.created_at + 7.hours).to_date === (Time.now.utc + 7.hours).to_date}
  end

  def self.date_today
  	(Time.now.utc - 7.hours).strftime("%B %-d, %Y")
  end

  def self.archived_grouped_and_ordered_by_date
  	Announcement.order('created_at desc').where(archived: true).group_by(&:date)
  end

  def date
  	(created_at.utc - 7.hours).strftime("%B %-d, %Y")
  end
end
