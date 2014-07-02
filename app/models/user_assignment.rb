class UserAssignment < ActiveRecord::Base
  attr_accessible :id, :assignment_id, :text, :user_id, :upload, :link, :point_value, :question_response,:complete, :rating
  has_attached_file :upload,
    :bucket => 'duhonline'
  validates_attachment_size :upload, :less_than => 20.megabytes
  belongs_to :user
  belongs_to :assignment
  has_many :user_comments, as: :commentable
  acts_as_voteable

end
