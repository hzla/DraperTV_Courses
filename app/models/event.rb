class Event < ActiveRecord::Base
  attr_accessible :name, :start_time, :description, :location, :user_id, :color, :url
  belongs_to :user


  def deliver
    sleep 10 # simulate long newsletter delivery
    update_attribute(:delivered_at, Time.zone.now)
  end


end
