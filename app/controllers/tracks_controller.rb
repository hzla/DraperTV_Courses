class TracksController < ApplicationController
  before_filter :authenticate_user!


  def show
    @track = Track.find params[:id]
    @lessons = @track.lessons
    @topic = @track.topic
    sidebarindex
  end
end
