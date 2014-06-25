class UserAssignment < ActiveRecord::Base
  attr_accessible :id, :assignment_id, :text, :user_id, :upload, :link, :point_value, :question_response,:complete, :rating
  has_attached_file :upload,
    :bucket => 'duhonline'
  validates_attachment_size :upload,
    :less_than => 15.megabytes,
    :message => "Sorry, your attachment must be less than 15MB"
  belongs_to :user
  belongs_to :assignment
  has_many :user_comments, as: :commentable
end
