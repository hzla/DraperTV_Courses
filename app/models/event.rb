# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  start_time  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  location    :string(255)
#  user_id     :integer
#

class Event < ActiveRecord::Base
  attr_accessible :name, :start_time, :description, :location, :user_id
  belongs_to :user
  has_many :user_comments, as: :commentable
end
