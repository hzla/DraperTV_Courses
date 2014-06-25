class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index

  	@activities =  Activity.all
    @posts = Post.all
    @comments = UserComment.all

     @commentableIDs = []
     @comments.each do |com|
       if com.user_id ==  current_user.id
         @commentableIDs << com.commentable_id
       end
     end

     @posts.each do |post|
       if post.user_id ==  current_user.id
         @commentableIDs << post.id
       end
     end
     @commentableIDs = @commentableIDs.uniq

  @trackableIDs = []
    @activities.each do |activity|
      @trackable = activity.trackable_type
      arr = eval(@trackable)
      if @commentableIDs.include? UserComment.where(:id => activity.trackable_id).first.commentable_id
         @trackableIDs << activity.trackable_id
       end
    end

    @activities = Activity.order("created_at desc").where("trackable_id IN (?)", @trackableIDs).where.not(:user_id => current_user.id).page(params[:page]).per(10).includes(:trackable)

# .where("user_id NOT IN (?)", User.where(:role => "admin").pluck(:id))
    #Creating a list of objects that the current user have COMMENTED on

    # @commentableIDs = []
    # @comments.each do |com|
    #    @commentableIDs << com.commentable_id
    # end

    # @posts.each do |post|
    #    @commentableIDs << post.id
    # end


    #activites where the posts relates to me

    #End of the list that contains Object Ids that this User commented on

    respond_to do |format|
      format.js
      format.html
    end
  end

end

