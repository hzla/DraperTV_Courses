class Comment < ActiveRecord::Base
	attr_accessible :user_id, :lesson_id, :body
	belongs_to :user
	belongs_to :lesson
end
