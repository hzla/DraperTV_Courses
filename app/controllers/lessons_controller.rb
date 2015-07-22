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
  	@comment = Comment.new lesson_id: @lesson.id
  	sidebarindex
  end
end
