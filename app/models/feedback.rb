# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feedback < ActiveRecord::Base
  attr_accessible :content, :type
end
