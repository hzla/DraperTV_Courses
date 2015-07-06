class LessonsController < ApplicationController
  
  def show
  	@lesson = Lesson.find params[:id]
  	@track = @lesson.track
  	@topic = @track.topic
  	@tracks = @topic.tracks
  	@comment = Comment.new lesson_id: @lesson.id
  	sidebarindex
  end

  def complete
	@lesson = Lesson.find params[:id]
	@lesson.update_attributes finished: true
	redirect_to lesson_path(@lesson)
  end
end
