class ProgressesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    lesson = Lesson.find(params[:progress][:model_id]).complete current_user
    track = lesson.track
    added_karma = 5
    if track.complete? current_user
    	added_karma += 10
    end
    if track.topic.complete? current_user
    	added_karma += 20
    end
    current_user.update_title_and_karma added_karma
    redirect_to lesson_path(lesson.next_lesson)
  end
end