class UserCommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_commentable
  load_and_authorize_resource
  
  def index
    #@commentable = Assignment.find(params[:assignment_id])
    @comments = @commentable.user_comments.order('created_at')
    @activities =  Activity.all
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
    @activities =  Activity.all
    @activities = Activity.order("created_at desc")

    #we will need to find the Post id Through Users relation to the Comments
    #And this is because Activity Track, tracks Users actions, it breaks down from there.
    
    if @comment.commentable_type == "Post"
      @posts = Post.all
      @user_comments = UserComment.all 

        listUsers = []  
        @comments = UserComment.all
        @comments.each do |com|
          if com.commentable_id ==  @comment.commentable_id 
            listUsers << com.user_id 
          end
        end

        @posts = Post.all
        @posts.each do |po|
          if po.id ==  @comment.commentable_id 
            listUsers << po.user_id 
          end        
        end
        @posts = Post.all
        @posts.each do |po|
          if po.user_id ==  @comment.user_id 
            listUsers << po.user_id 
          end        
        end
        @topic = Post.find_by_id(@comment.commentable_id)
        @commenter = User.find_by_id(@comment.user_id)
        listUsers << @topic.user_id


          listUsers = listUsers.uniq
          listUsers.delete(current_user.id)
          listUsers.each do |usr|
            PrivatePub.publish_to("/layouts/#{usr}", "$('#notifications').removeClass('empty');
              $('#notifications').addClass('notifications');")
          end              


    elsif @comment.commentable_type == "Assignment"

      @posts = UserAssignment.all
      @user_comments = UserComment.all 

        listUsers = []  
        @comments = UserComment.all
        @comments.each do |com|
          if com.commentable_id ==  @comment.commentable_id 
            listUsers << com.user_id 
          end
        end

        @posts = UserAssignment.all
        @posts.each do |po|
          if po.id ==  @comment.commentable_id 
            listUsers << po.user_id 
          end        
        end
        @posts = UserAssignment.all
        @posts.each do |po|
          if po.user_id ==  @comment.user_id 
            listUsers << po.user_id 
          end        
        end
        @topic = UserAssignment.find_by_assignment_id(@comment.commentable_id)


        @commenter = User.find_by_id(@comment.user_id)
        listUsers << @topic.user_id


          listUsers = listUsers.uniq
          listUsers.delete(current_user.id)
          listUsers.each do |usr|
            PrivatePub.publish_to("/layouts/#{usr}", "$('#notify').append('#{@commenter.first_name} commented on #{@topic}'); $('#notifications').removeClass('empty');
              $('#notificatiosn').addClass('notifications');")
          end 

    elsif @comment.commentable_type == "Event"

      @posts = Event.all
      @user_comments = UserComment.all 

        listUsers = []  
        @comments = UserComment.all
        @comments.each do |com|
          if com.commentable_id ==  @comment.commentable_id 
            listUsers << com.user_id 
          end
        end

        @posts = Event.all
        @posts.each do |po|
          if po.id ==  @comment.commentable_id 
            listUsers << po.user_id 
          end        
        end
        @posts = Event.all
        @posts.each do |po|
          if po.user_id ==  @comment.user_id 
            listUsers << po.user_id 
          end        
        end
        @topic = Event.find_by_id(@comment.commentable_id)


        @commenter = User.find_by_id(@comment.user_id)
        listUsers << @topic.user_id


          listUsers = listUsers.uniq
          listUsers.delete(current_user.id)
          listUsers.each do |usr|
            PrivatePub.publish_to("/layouts/#{usr}", "$('#notify').append('#{@commenter.first_name} commented on #{@topic.name}'); $('#notifications').removeClass('empty');
              $('#notifications').addClass('notifcations');")
          end 



      else
      end


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

