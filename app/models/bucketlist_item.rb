# == Schema Information
#
# Table name: bucketlist_items
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  bucketlist_id :integer
#  title         :string(255)
#  body          :text
#  complete      :boolean
#

class BucketlistItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :bucketlist
  attr_accessible :title, :body, :complete
end
