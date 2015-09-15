class TopicsController < ApplicationController

  def index
    @user = current_user
    @topics = Topic.progress_infos @user
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
    @user = current_user
    @tracks = Track.progress_infos @user, @topic.tracks.order(:order)
    @participants = @topic.participants
    @meta_description = @topic.summary
    @title = "#{@topic.camel_case_name} - Courses - DraperTV"
  end
end
