class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource :find_by => :slug

  def show
  	@user = current_user
    @courses = Course.all
    @assignments = Assignment.all
    @user_assignments = UserAssignment.all
  	#@user = User.find(params[:id])
  	if @user
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end


  end

  def profile
    @user = User.friendly.find(params[:id])
    @courses = Course.includes(:assignments).all
    @assignments = Assignment.all
    #@assignment = Assignment.find(params[:id])
    @user_assignments = UserAssignment.all
    @posts = Post.where(:user_id => @user.id).order('created_at desc')
    @activities =  Activity.all
    @activities = Activity.order("created_at desc")

    @activity_feeds =  ActivityFeed.all
    @activity_feeds = ActivityFeed.page(params[:page]).per(10).order("created_at desc").includes(:tobetrackable)
    @leaders = User.order('pcounter').limit(10)
    if @user
      render action: :profile
    else
      render file: 'public/404', status: 404, formats: [:html]
    end

    def email_register
      if @user
        UserRegistered.registration_confirmation(@user).deliver
      else
      end
    end
  end

end