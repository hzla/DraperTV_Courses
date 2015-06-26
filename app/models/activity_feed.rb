class ActivityFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :tobetrackable, polymorphic: true
  attr_accessible :action, :tobetrackable
end

