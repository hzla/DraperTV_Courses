class TracksController < ApplicationController

  def show
    @track = Track.find params[:id]
    @lessons = @track.type_sorted_lessons
    #change into a hash instead of nested array
    @topic = @track.topic
    sidebarindex
  end
end
