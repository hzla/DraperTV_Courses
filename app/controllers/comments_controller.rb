class CommentsController < ApplicationController
  before_filter :authenticate_user!
  include ApplicationHelper
  
  def create
    comment = Comment.new params[:comment]
    comment.user_id = current_user.id
    lesson = comment.lesson
    @user = current_user


    if comment.save!
      if comment.comment_type == "chat"
        broadcast ama_path(comment.ama)+ "/chat", comment.to_json
        render nothing: true and return
      elsif comment.parent_id
        render partial: 'child_comment', locals: {child_comment: comment} and return
      else
        commentable = comment.ama_id ? comment.ama : lesson
        render partial: 'comment', locals: {comment: comment, commentable: commentable}
      end
   	end
  end

  def show
    comment = Comment.find params[:id]
    @user = current_user
    render partial: 'chat_comment', locals: {comment: comment} and return
  end

  def upvote
  	comment = Comment.find params[:id]
    comment.toggle_upvote_from current_user
    render json: {value: comment.get_upvotes.size}
  end
end