class TracksController < ApplicationController

  def show
    @track = Track.friendly.find params[:id]
    @lessons = @track.type_sorted_lessons
    @lesson_count = @lessons.flatten.reject! {|n| n.class != Lesson}.count
    @topic = @track.topic
    @participants = @track.participants
    @user = current_user
    @tutorial = params["tutorial"] == "true"
    
    if @user && @user.show_track_tutorial
      @user.update_attribute(:show_track_tutorial, false)
      redirect_to track_path(id: @track.id, tutorial: true)
    end
    
    @meta_description = @track.summary
    @title = "#{@track.camel_case_name} - Courses - DraperTV"
  end

  def index
  	render json: {chapters: Track.to_draper_tv_chapters}
  end
end
