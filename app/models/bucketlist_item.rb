class BucketlistItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :bucketlist
  attr_accessible :title, :body, :complete
end
