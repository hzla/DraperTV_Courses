class LessonsController < ApplicationController
  
  def show
  	@lesson = Lesson.find params[:id]
  	@track = @lesson.track
  	@topic = @track.topic
  	@tracks = @topic.tracks
  	@comment = Comment.new lesson_id: @lesson.id
  	sidebarindex
  end
end
