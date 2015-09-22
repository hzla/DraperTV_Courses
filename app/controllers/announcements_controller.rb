class AnnouncementsController < ApplicationController
  before_filter :authenticate_user!
  include ApplicationHelper
  
  def index
  	@announcements = Announcement.archived_grouped_and_ordered_by_date
  end

  def destroy
  	@announcement = Announcement.find(params[:id]).destroy
  	redirect_to root_path
  end

  def create
  	Announcement.create params[:announcement]
  	redirect_to root_path
  end

  def hide
  	Announcement.today.map {|n| n.update_attributes archived: true}
  	redirect_to root_path
  end
end