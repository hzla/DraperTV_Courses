class ActivityFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :tobetrackable
end
