class TracksController < ApplicationController

  def show
    @track = Track.find params[:id]
    @lessons = @track.lessons
    @topic = @track.topic
    sidebarindex
  end
end
