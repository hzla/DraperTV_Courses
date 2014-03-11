# == Schema Information
#
# Table name: user_assignments
#
#  id                  :integer          not null, primary key
#  text                :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  upload_file_name    :string(255)
#  upload_content_type :string(255)
#  upload_file_size    :integer
#  upload_updated_at   :datetime
#  user_id             :integer
#  assignment_id       :integer
#  link                :string(255)
#

class UserAssignment < ActiveRecord::Base
  attr_accessible :id, :assignment_id, :text, :user_id, :upload, :link
  has_attached_file :upload, 
    :bucket => 'duhonline'
  validates_attachment_size :upload, :less_than => 20.megabytes
  belongs_to :user
  belongs_to :assignment
  has_many :user_comments, as: :commentable
end
