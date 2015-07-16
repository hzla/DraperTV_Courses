class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    comment = Comment.new params[:comment]
    comment.user_id = current_user.id
    lesson = comment.lesson

    if comment.save!
   		redirect_to lesson_path(lesson)
   	end
  end

  def upvote
  	comment = Comment.find params[:id]
  	comment.liked_by current_user
  	comment.user.update_title
  	redirect_to lesson_path(comment.lesson)
  end
end