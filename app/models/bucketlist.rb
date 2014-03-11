# == Schema Information
#
# Table name: bucketlists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :bucketlist_items
end
