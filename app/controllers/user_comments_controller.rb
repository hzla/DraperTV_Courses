class UserCommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_commentable
  load_and_authorize_resource

  def index
    #@commentable = Assignment.find(params[:assignment_id])
    @comments = @commentable.user_comments.order('created_at DESC')
    @activities =  Activity.all
  end

  def show
    @comments = @commentable.user_comments.order('created_at DESC')
    @comment = @commentable.user_comments.new(params[:user_comment])

    respond_to do |format|
      #format.js { @comments = @commentable.user_comments }
      format.html { redirect_to @commentable }
      end
  end

def vote_for_comment
  begin
    #@comment = UserComment.find(params[:id])
    current_user.vote_for(@comment = UserComment.find(params[:id]))
    redirect_to :back
  rescue
    render :nothing => true, :status => 404
  end
end

def unvote_for_comment
  begin
    @comment = UserComment.find(params[:id])
    current_user.unvote_for(@comment)
    redirect_to :back
  rescue
    render :nothing => true, :status => 404
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
    @user = User.find(@comment.user_id)
    @words = @comment.content.split.size.to_i + @user.char_points.to_i
    @user.update_column(:char_points, 1 * @words)
    commentsize = @comment.content.split.size.to_i
    cpcalculate(commentsize)
    @activities =  Activity.all
    @activities = Activity.order("created_at desc")

    begin
      notifSend(@comment)
    rescue => exception
        ExceptionNotifier.notify_exception(exception)
        PrivatePub.publish_to("/layouts/comments","$('##{@commentable.id}').empty();$('##{@commentable.id}').append(#{render(:partial => 'user_comments/postcomments')});")
    rescue
    ensure
      if @comment.save
        track_activity @comment
        @comments = @commentable.user_comments.order('created_at desc')
        #refresh_dom_with_partial('div#comments_container', 'comments')
          if @comment.commentable_type == "Assignment"
            respond_to do |format|
              format.html {  }
              format.js { render :commentAssignment }
            end
          elsif @comment.commentable_type == "UserAssignment"
            @comments = @commentable.user_comments.order('created_at asc')
            @user_assignment = UserAssignment.where(:id => @comment.commentable_id).first
            respond_to do |format|
              format.html {  }
              format.js { render :commentUA }
            end
          elsif @comment.commentable_type == "Event"
            @comments = @commentable.user_comments.order('created_at asc')
            respond_to do |format|
              format.html {  }
              format.js { render :commentEvent }
            end
          else
            respond_to do |format|
              format.html { }
              format.js { render :commentVote }
            end
          end
      else
        render :new
      end
      end # end rescue
    end


  def destroy
    @comments = @commentable.user_comments.order('created_at desc')
    @comment = UserComment.find(params[:id])
    @user = User.find(@comment.user_id)
    @words =  @user.char_points.to_i - @comment.content.split.size.to_i
    @user.update_column(:char_points, 1 * @words)
    @user.update_column(:pcounter, @user.pcounter.to_i - @comment.content.split.size.to_i)

    @activities = Activity.all
    @activities.find_by_trackable_id(@comment.id).destroy

      @comments.each do |com|
        if com.commentable_id == @comment.id
            @activities.find_by_trackable_id(com.id).destroy
        end
      end
    if current_user.id == @comment.user_id
      @comment.destroy
        @comments = @commentable.user_comments.order('created_at desc')
        #refresh_dom_with_partial('div#comments_container', 'comments')
          if @comment.commentable_type == "Assignment"
            respond_to do |format|
              format.html {  }
              format.js { render :commentAssignment }
            end
          elsif @comment.commentable_type == "UserAssignment"
            @comments = @commentable.user_comments.order('created_at asc')
            @user_assignment = UserAssignment.where(:id => @comment.commentable_id).first
            respond_to do |format|
              format.html {  }
              format.js { render :commentUA }
            end
          elsif @comment.commentable_type == "Event"
            @comments = @commentable.user_comments.order('created_at asc')
            respond_to do |format|
              format.html {  }
              format.js { render :commentEvent }
            end
          else
            respond_to do |format|
              format.html { }
              format.js { render :commentVote }
            end
          end
    end
  end

    # notifSend is method for the notification check-sum:
    #It checks if the comment's commentable type is a Post or Event or Assignment
    # in order to notify the users per their ownership of the post.
def notifSend(comment)

  @comments = UserComment.all
  begin
    if @comment.commentable_type == "Post"
        listUsers = []
       @posts = Post.all

        @comments.each do |com|
          if com.commentable_id ==  @comment.commentable_id
            listUsers << com.user_id
          end
        end

        @posts.each do |po|
          if po.id ==  @comment.commentable_id
            listUsers << po.user_id
          end
        end

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
          @user = User.find(usr)
          @user.increment!(:ncounter)
          PrivatePub.publish_to("/layouts/#{usr}",
            "$('#notifications').removeClass('empty');
            $('#notification').addClass('notifications');
            $('.red-circle').show();
            $('.red-circle p').text(#{@user.ncounter});")
        end

      elsif @comment.commentable_type == "Assignment"

        @assignment = UserAssignment.all

        listUsers = []
        @comments.each do |com|
          if com.commentable_id ==  @comment.commentable_id
            listUsers << com.user_id
          end
        end

        @assignment = UserAssignment.all
        @assignment.each do |po|
          if po.id ==  @comment.commentable_id
            listUsers << po.user_id
          end
        end

        @assignment = UserAssignment.all
        @assignment.each do |po|
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
          if User.find_by_id(usr).present?
            @user = User.find(usr)
            @user.increment!(:ncounter)
            PrivatePub.publish_to("/layouts/#{usr}",
              "$('#notifications').removeClass('empty');
              $('#notification').addClass('notifications');
              $('.red-circle').show();
              $('.red-circle p').text(#{@user.ncounter});")
          end
        end

      elsif @comment.commentable_type == "Event"
        @posts = Event.all

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
          if User.find_by_id(usr).present?
            @user = User.find(usr)
            @user.increment!(:ncounter)
            PrivatePub.publish_to("/layouts/#{usr}",
              "$('#notifications').removeClass('empty');
               $('#notification').addClass('notifications');
               $('.red-circle').show();
               $('.red-circle p').text(#{@user.ncounter});")
          end

        end
      else
      end # end of if @comment.commentable_type block
  rescue

  end
end


private

  def load_commentable
    resource, id = request.path.split('/')[1,2] # /photos/1
    #resource, id = @assignment.id
    @commentable = resource.singularize.classify.constantize.find(id) # photo.find(1)
  end

  # alternatives
end

