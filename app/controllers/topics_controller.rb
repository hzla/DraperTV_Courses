class TopicsController < ApplicationController
  # before_filter :authenticate_user!
  # load_and_authorize_resource

  def index
    @topics = Topic.all.order(:order)
    @user = current_user
    @page = "courses"
  end

  def show
    @topic = Topic.find params[:id]
    @tracks = @topic.tracks
  end
end
