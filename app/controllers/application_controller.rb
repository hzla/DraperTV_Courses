class ApplicationController < ActionController::Base
    include ApplicationHelper
    protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  before_filter :set_device_type
  before_filter :set_meta_tags

  def after_sign_in_path_for(resource)
    if !params[:resource_id]
      root_path
    else
      "/#{params[:resource_type].pluralize}/#{params[:resource_id]}"
    end
  end

  protected

  def set_device_type 
    @mobile = true if browser.mobile?
  end

  def set_meta_tags
    @title = "Courses - DraperTV"
    @meta_description = "Learn how to build a startup with DraperTV Courses. We bring the magic of Silicon Valley and Draper University education online to accelerate your ideas, businesses, and products."
  end
end

