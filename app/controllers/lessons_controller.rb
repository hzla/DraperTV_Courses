class LessonsController < ApplicationController
  def show
  	@lesson = Lesson.find params[:id]
  	@mod = @lesson.mod
  	@track = @mod.track
  	@comment = Comment.new lesson_id: @lesson.id
  	sidebarindex
  end
end
