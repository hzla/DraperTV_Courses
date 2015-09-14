class TopicsController < ApplicationController

  def index
    @topics = Topic.all.order(:order)
    @user = current_user
    @page = "courses"
    @announcements = Announcement.today
    @tutorial = params["tutorial"] == "true"
    if @user && @user.show_topic_tutorial
      @user.update_attribute(:show_topic_tutorial, false)
      redirect_to topics_path(tutorial: true)
    end
  end

  def show
    @topic = Topic.friendly.find params[:id]
    @tracks = @topic.tracks
    @user = current_user
    @participants = @topic.participants
    @meta_description = @topic.summary
    @title = "#{@topic.camel_case_name} - Courses - DraperTV"
  end
end
