class LessonsController < ApplicationController
  include ApplicationHelper
  before_filter :only_admins_allowed, except: "show"
  
  def show
    @lesson = Lesson.find params[:id]
    @track = @lesson.track
    @topic = @track.topic
    @user = current_user
    redirect_to "/users/sign_up?resource_id=#{@lesson.id}&resource_type=lesson" and return if !current_user
    redirect_to new_charge_path(lesson_id: @lesson.id) and return if !current_user.paid	&& !@topic.free 

  	@tracks = @topic.tracks
    if @lesson.discussion
    	@comment = Comment.new lesson_id: @lesson.id
      @comments = @lesson.comments.includes(:user)
      @sort = "date"
      if params["sort"] == "top"      
        @comments = @comments.sort_by {|c| c.get_upvotes.size}.reverse
        @sort = "top"
      end
    end
  
    @user = current_user
    @participants = @lesson.participants
    Progress.where(user_id: @user.id, model_type: "lesson", model_id: @lesson.id, percent_complete: 0).first_or_create
  end

  def edit
    @lesson = Lesson.find params[:id]
  end

  def update
    @lesson = Lesson.find params[:id]
    params[:lesson][:lesson_type] = params[:lesson][:lesson_type].downcase.strip
    @lesson.update_attributes lesson_params
    redirect_to lesson_path(@lesson)
  end

  def new
    @lesson = Lesson.new
  end

  def create
    params[:lesson][:lesson_type] = params[:lesson][:lesson_type].downcase.strip
    track = Track.find_by_name params[:chapter].upcase.strip
    lesson = Lesson.create params[:lesson]
    lesson.update_attributes track_id: track.id
    redirect_to lesson_path(lesson)
  end

  private

  def only_admins_allowed
    if current_user.role != "admin"
      redirect_to root_path and return
    end
  end

  def lesson_params
    params.require(:lesson).permit(:lesson_type, :video, :started, :finished, :video_uid, :video_title, :video_author, :body, :discussion, :description, :track_id, :order, :video_length, :slug)
  end

end
