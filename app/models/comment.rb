class Comment < ActiveRecord::Base
	attr_accessible :user_id, :lesson_id, :body, :ama_id, :parent, :parent_id
	belongs_to :user
	belongs_to :lesson
	belongs_to :ama
	acts_as_votable
	after_create :self_upvote
	has_ancestry


	def self_upvote
		liked_by user
	end
end
