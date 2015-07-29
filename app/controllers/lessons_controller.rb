class LessonsController < ApplicationController
  # before_filter :authenticate_user!
  # load_and_authorize_resource
  include ApplicationHelper
  
  def show
    @lesson = Lesson.find params[:id]
    redirect_to "/users/sign_up?lesson_id=#{@lesson.id}" and return if !current_user
    redirect_to new_charge_path(lesson_id: @lesson.id) and return if !current_user.paid	
  	@track = @lesson.track
  	@topic = @track.topic
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
  end
end
