class TopicsController < ApplicationController
  # before_filter :authenticate_user!
  # load_and_authorize_resource

  def index
    @topics = Topic.all.order(:order)
    @user = current_user
    @page = "courses"
    @tutorial = params["tutorial"] == "true"
    if current_user && current_user.show_topic_tutorial
      @user.update_attributes show_topic_tutorial: false
      redirect_to topics_path(tutorial: true)
    end
  end

  def show
    @topic = Topic.find params[:id]
    @tracks = @topic.tracks
    @participants = @topic.participants
  end
end
