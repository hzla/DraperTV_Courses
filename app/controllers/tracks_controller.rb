class TracksController < ApplicationController

  def show
    @track = Track.find params[:id]
    @lessons = @track.type_sorted_lessons
    @lesson_count = @lessons.flatten.reject! {|n| n.class != Lesson}.count
    #change into a hash instead of nested array
    @topic = @track.topic
    sidebarindex
  end
end
