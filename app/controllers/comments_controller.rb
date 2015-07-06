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
end