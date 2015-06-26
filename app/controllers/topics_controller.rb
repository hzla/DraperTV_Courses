class TopicsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @topics = Topic.all
    sidebarindex
  end

  def show
    @topic = Topic.find params[:id]
    @tracks = @topic.tracks.includes(:mods)
    sidebarindex
  end
end
