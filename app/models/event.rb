class Event < ActiveRecord::Base
  attr_accessible :name, :start_time, :description, :location, :user_id
  belongs_to :user
  has_many :user_comments, as: :commentable
end