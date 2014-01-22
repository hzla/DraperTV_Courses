class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :load

def load
  @posts = Post.all(:order => 'created_at desc')
  @post = Post.new
  @messages = Message.all
  @message = Message.new
  @activities =  Activity.all

end

# GET /posts
# GET /posts.json
def index
  @posts = Post.order('created_at DESC').page(params[:page]).per(10)
  @post = Post.new
  @users = User.all
  @user = User.find_by_id(@post.user_id)
   @instagram_draperu = Instagram.tag_recent_media('draperu', options = {count: 20})
    @instagram_draperuonline = Instagram.tag_recent_media('draperuonline', options = {count: 20})
  respond_to do |format|
    format.html # show.html.erb
    format.js #{ render js: @post }
  end

end

# GET /posts/1
# GET /posts/1.json
def show
  @post = Post.find(params[:id])
  @commentable = @post
  @comments = @commentable.user_comments.order(:created_at)
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
      if @post.save
       track_activity @post  
       respond_to do |format|
          format.js { redirect_to :back }
          #format.html # new.html.erb
          format.html { redirect_to :back } #{ redirect_to :back, :remote => true }
          PrivatePub.publish_to("/layouts/posts", "$('.header').show();")

        end
      else  
          render :new  
      end  
  end 



# PUT /posts/1
# PUT /posts/1.json
def update
  @post = Post.find(params[:id])

  respond_to do |format|
    track_activity @post  
    if @post.update_attributes(params[:post])
      format.html #{ redirect_to @post, notice: 'Post was successfully updated.' }
      format.js #{ head :no_content }
    else
      format.html { render action: "edit" }
      format.js #{ render js: @post.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /posts/1
# DELETE /posts/1.json
def destroy
  @post = Post.find(params[:id])
  @post.destroy
  respond_to do |format|
    format.html { redirect_to posts_url }
    #format.js { head :no_content }
  end
end
end
