class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
  	@activities =  Activity.all
    @activities = Activity.page(params[:page]).per(10).order("created_at desc").includes(:trackable)
    @posts = Post.all
    @comments = UserComment.all

    #Creating a list of objects that the current user have COMMENTED on
     @commentableIDs = []
     @comments.each do |com|
       if com.user_id ==  current_user.id
         @commentableIDs << com.commentable_id
       end
     end
    #End of the list that contains Object Ids that this User commented on


    respond_to do |format|
      format.js
      format.html
    end
  end

end

