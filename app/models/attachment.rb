# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attachment < ActiveRecord::Base
  attr_accessible :type, :url
end
