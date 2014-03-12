# == Schema Information
#
# Table name: user_comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class UserComment < ActiveRecord::Base
  attr_accessible  :content, :user_id
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
end
