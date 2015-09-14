class ProgressesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    lesson = Lesson.find(params[:progress][:model_id]).complete current_user
    current_user.complete lesson
    next_resource = lesson.next_lesson
    redirect_to (next_resource.class == Lesson ? lesson_path(next_resource) : topic_path(next_resource))
  end
end