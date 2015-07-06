class TopicsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @topics = Topic.all.order(:order)
    sidebarindex
  end

  def show
    @topic = Topic.find params[:id]
    @tracks = @topic.tracks
    sidebarindex
  end
end
