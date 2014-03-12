# == Schema Information
#
# Table name: badges
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  user_id           :integer
#  course_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#

class Badge < ActiveRecord::Base
  attr_accessible :name, :user_id, :course_id
  attr_accessible :icon
  has_attached_file :icon, :default_url => "/images/icon_missing.png"
  belongs_to :user
end
