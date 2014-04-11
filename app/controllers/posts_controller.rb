class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :load
  respond_to :html, :json

def load
  @posts = Post.all
  @post = Post.new
  @messages = Message.all
  @message = Message.new
end
# GET /posts
# GET /posts.json
def index
  @leaders = User.where("pcounter is not null").order('pcounter DESC').limit(8)
  #@posts = Post.plusminus_tally.order('plusminus_tally desc').page(params[:page]).per(10)
  #listPosts = []
  #@posts = Post.plusminus_tally.order('plusminus_tally desc')
  @posts = Post.order('created_at DESC').page(params[:page]).per(10)
  @post = Post.new
  # @users = User.all
  # @user = User.find_by_id(@post.user_id)
  @instagram_draperu = Instagram.tag_recent_media('draperu', options = {count: 20})
  @instagram_draperuonline = Instagram.tag_recent_media('draperuonline', options = {count: 20})
  respond_to do |format|
    format.html
    format.js #{ render js: @post }
  end
end

def vote_for_post
  begin
    @post = Post.find(params[:post_id])
    current_user.vote_for(@post)
    respond_to do |format|
      format.js
    end
  rescue
    render :nothing => true, :status => 404
  end
end

def unvote_for_post
  begin
    @post = Post.find(params[:post_id])
    current_user.unvote_for(@post)
    respond_to do |format|
      format.js
    end
  rescue
    render :nothing => true, :status => 404
  end
end


# GET /posts/1
# GET /posts/1.json
def show
  @post = Post.find(params[:id])
  @commentable = @post
  @comments = @commentable.user_comments.order('created_at desc')
  @comment = UserComment.new

  respond_to do |format|
    format.html # show.html.erb
    format.js #{ render js: @post }
  end
end

# GET /posts/new
# GET /posts/new.json
def new
  @post = Post.new

  respond_to do |format|
    format.html # new.html.erb
    format.js 
  end
end

# GET /posts/1/edit
def edit
  @post = Post.find(params[:id])
end

# POST /posts
# POST /posts.json

def create 
    @posts = Post.all(:order => 'created_at desc') 
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
      begin
        if @post.save
         track_activity @post  
         respond_to do |format|
            format.js { redirect_to :back }
            #format.html # new.html.erb
            format.html { redirect_to :back } #{ redirect_to :back, :remote => true }

            #below line will send a notification to 
            #everyone that there is a new post and they can refres
            PrivatePub.publish_to("/layouts/posts", "$('.headerAlert').show();")

          end
        else  
            render :new  
        end  
      rescue => exception
          ExceptionNotifier.notify_exception(exception)
        if @post.save
         track_activity @post  
         respond_to do |format|
            format.js { redirect_to :back }
            #format.html # new.html.erb
            format.html { redirect_to :back } #{ redirect_to :back, :remote => true }
            #below line will send a notification to 
            #everyone that there is a new post and they can refres
          end
        else  
            render :new  
        end          
      end

  end 

# PUT /posts/1
# PUT /posts/1.json

def update
  @post = Post.find(params[:id])
  
  if current_user.id == @post.user_id
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post }
        format.json { respond_with_bip(@post) }
      else
        format.html { redirect_to :back, :notice => 'Something went wrong'}
      end
    end
  end

  # respond_to do |format|
  #   track_activity @post  
  #   if @post.update_attributes(params[:post])
  #     format.html #{ redirect_to @post, notice: 'Post was successfully updated.' }
  #     #format.js #{ head :no_content }
  #   else
  #     format.html { render action: "edit" }
  #     format.js #{ render js: @post.errors, status: :unprocessable_entity }
  #   end
  # end
end

# DELETE /posts/1
# DELETE /posts/1.json
def destroy
  @post = Post.find(params[:id])
  @post.destroy

  @comments =  UserComment.all
  @activities = Activity.all 
  @activities.find_by_trackable_id(@post.id).destroy

  @comments.each do |com|
    if com.commentable_id == @post.id
        @activities.find_by_trackable_id(com.id).destroy
        com.destroy
    end  
  end

  respond_to do |format|
    format.html { redirect_to posts_url }
    #format.js { head :no_content }
  end
end

end 
