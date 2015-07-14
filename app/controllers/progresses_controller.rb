class ProgressesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def create
    lesson = Lesson.find(params[:progress][:model_id]).complete current_user
    redirect_to lesson_path(lesson.next_lesson)
  end

end