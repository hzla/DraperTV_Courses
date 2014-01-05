class Badge < ActiveRecord::Base
  attr_accessible :name, :user_id, :course_id
  attr_accessible :icon
  has_attached_file :icon, :default_url => "/images/icon_missing.png"
  belongs_to :user
end
