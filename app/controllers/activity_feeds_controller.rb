class ActivityFeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  	@activity_feeds =  ActivityFeed.all
    @activity_feeds = ActivityFeed.page(params[:page]).per(10).order("created_at desc").includes(:tobetrackable)
    @comments = UserComment.all
    @comments = @comments.order('created_at desc')
    @comment = UserComment.new
    @leaders = User.where.not(role: 'admin').order('pcounter DESC').limit(10)
  end

end
