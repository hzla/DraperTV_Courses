class ActivityFeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
  	@activity_feeds =  ActivityFeed.all
    @activity_feeds = ActivityFeed.page(params[:page]).per(10).order("created_at desc").includes(:tobetrackable)
    @comments = UserComment.all
    @comments = @comments.order('created_at desc')
    # @assignment = Assignment.find(params[:id])
    # @commentable = @assignment
    @comment = UserComment.new
    @leaders = User.order('pcounter').limit(10)

    respond_to do |format|
      format.js
      format.html
    end
  end

end
