class Event < ActiveRecord::Base
  attr_accessible :name, :start_time, :description, :location, :user_id
  belongs_to :user
  has_many :user_comments, as: :commentable


  def deliver
    sleep 10 # simulate long newsletter delivery
    update_attribute(:delivered_at, Time.zone.now)
  end


end
