class CommentsController < ApplicationController
  before_filter :get_comment, except: "create"
  include ApplicationHelper
  
  def create
    comment = Comment.new comment_params
    lesson = comment.lesson
    @user = current_user
    comment.user_id = @user.id
    
    if comment.save!
      if comment.comment_type == "chat"
        broadcast ama_path(comment.ama)+ "/chat", comment.to_json
        render nothing: true and return
      elsif comment.parent_id
        comment.self_upvote
        render partial: 'child_comment', locals: {child_comment: comment} and return
      else
        commentable = comment.ama_id ? comment.ama : lesson
        comment.self_upvote
        render partial: 'comment', locals: {comment: comment, commentable: commentable}
      end
   	end
  end

  def show
    @user = current_user
    render partial: 'chat_comment', locals: {comment: @comment} and return
  end

  def upvote
    @comment.toggle_upvote_from current_user
    render json: {value: @comment.get_upvotes.size}
  end

  def destroy
    @comment.destroy
    render nothing: true
  end

  private

  def get_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit :body, :user_id, :lesson_id, :ama_id, :ancestry, :parent_id, :comment_type
  end
end