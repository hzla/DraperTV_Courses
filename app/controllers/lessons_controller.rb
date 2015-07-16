class LessonsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource
  
  def show
  	@lesson = Lesson.find params[:id]
  	@track = @lesson.track
  	@topic = @track.topic
  	@tracks = @topic.tracks
  	@comment = Comment.new lesson_id: @lesson.id
  	sidebarindex
  end
end
