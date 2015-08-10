class TracksController < ApplicationController

  def show
    @track = Track.find params[:id]
    @lessons = @track.type_sorted_lessons
    @lesson_count = @lessons.flatten.reject! {|n| n.class != Lesson}.count
    #change into a hash instead of nested array
    @topic = @track.topic
    @participants = @track.participants
    @tutorial = params["tutorial"] == "true"
    if current_user && current_user.show_track_tutorial
      current_user.update_attribute(:show_track_tutorial, false)
      redirect_to track_path(id: @track.id, tutorial: true)
    end
  end

  def index
  	render json: {chapters: Track.to_draper_tv_chapters}
  end
end
