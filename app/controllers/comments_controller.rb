class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    comment = Comment.new params[:comment]
    comment.user_id = current_user.id
    lesson = comment.lesson

    if comment.save!
      if comment.comment_type == "chat"
        broadcast ama_path(comment.ama)+ "/chat", comment.to_json
        render nothing: true and return
      elsif comment.parent_id
        render partial: 'child_comment', locals: {child_comment: comment} and return
      else
        commentable = comment.ama_id ? comment.ama : comment.lesson
        render partial: 'comment', locals: {comment: comment, commentable: commentable}
      end
   	end
  end

  def show
    comment = Comment.find params[:id]
    if comment.comment_type == "chat"
      render partial: 'chat_comment', locals: {comment: comment} and return
    elsif comment.parent_id
      render partial: 'child_comment', locals: {child_commnet: comment} and return
    else
      commentable = comment.ama_id ? comment.ama : comment.lesson
      render partial: 'comment', locals: {comment: comment, commentable: commentable}
    end
  end

  def upvote
  	comment = Comment.find params[:id]
    if comment.liked_by? current_user
      comment.unliked_by current_user
      comment.user.update_title_and_karma -1
    else
      comment.liked_by current_user
      comment.user.update_title_and_karma 1
    end
    render json: {value: comment.get_upvotes.size}
  end
end