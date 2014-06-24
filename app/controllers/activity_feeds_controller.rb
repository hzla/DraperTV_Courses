class ActivityFeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  	@activity_feeds =  ActivityFeed.all
    @activity_feeds = ActivityFeed.where("user_id NOT IN (?)", User.where(:role => "admin").pluck(:id)).page(params[:page]).per(20).order("created_at desc").includes(:tobetrackable)
    @comments = UserComment.all
    @comments = @comments.order('created_at desc')
    @comment = UserComment.new
    @leaders = User.where.not(role: 'admin').where("pcounter is not null").order('pcounter DESC').limit(10)
  end

end
