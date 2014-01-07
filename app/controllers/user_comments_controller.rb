class UserCommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_commentable
  
  def index
    #@commentable = Assignment.find(params[:assignment_id])
    @comments = @commentable.user_comments.order('created_at')
  end

  def show
    @comments = @commentable.user_comments.order('created_at')
    @comment = @commentable.user_comments.new(params[:user_comment])

    respond_to do |format|
      #format.js { @comments = @commentable.user_comments }
      format.html { redirect_to @commentable }
      end
  end

  def new
    @comment = @commentable.user_comments.new()
  end

  def create
    @users = User.all
    @comment = @commentable.user_comments.new(params[:user_comment])
    @comment.user_id = current_user[:id]
    #@commentable.user_comments.create(:user_id => current_user[:id])

    if @comment.save
      track_activity @comment  
      #refresh_dom_with_partial('div#comments_container', 'comments')
      respond_to do |format|
        format.js { @comments = @commentable.user_comments.order(:created_at) }
        format.html #{ redirect_to @commentable }
      end
    else
      render :new
    end
  end

  def destroy
    @comments = @commentable.user_comments.order('created_at')
    @comment = UserComment.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
        respond_to do |format|
          format.js { @comments = @commentable.user_comments.order(:created_at) }
          format.html #{ redirect_to @commentable }
        end
    end
    # if @comment.user == current_user
    #   @comment.destroy
    #   #format.js { @comments = @commentable.user_comments }
    #   #format.html #{ redirect_to @commentable }
    # else
    #   format.html { redirect_to :back, alert: 'You can\'t delete this comment.' }
    # end
  end

private
  
  def load_commentable
    resource, id = request.path.split('/')[1,2] # /photos/1
    #resource, id = @assignment.id
    @commentable = resource.singularize.classify.constantize.find(id) # photo.find(1)
  end
  # alternatives
end

