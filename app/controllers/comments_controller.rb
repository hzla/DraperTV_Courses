class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    comment = Comment.new params[:comment]
    comment.user_id = current_user.id
    lesson = comment.lesson

    if comment.save!
   		if comment.lesson_id
        redirect_to lesson_path(lesson) and return
      else
        redirect_to ama_path(comment.ama)
      end
   	end
  end

  def upvote
  	comment = Comment.find params[:id]
  	comment.liked_by current_user
  	comment.user.update_title_and_karma
    if comment.lesson
  	 redirect_to lesson_path(comment.lesson) and return
    else
      redirect_to ama_path(comment.ama)
    end
  end
end