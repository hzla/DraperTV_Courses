class ApplicationController < ActionController::Base
    include ApplicationHelper
  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Access denied."
  #   redirect_to root_url
  # end
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  helper_method :track_activity_feed
  helper_method :mailitnow
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
  before_filter :set_device_type
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_meta_tags

  #For all responses in this controller, return the CORS access control headers.
  if Rails.env.staging? || Rails.env.development?
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = 'http://fayesrvr.herokuapp.com'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = 'http://fayesrvr.herokuapp.com'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.
    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = 'http://fayesrvr.herokuapp.com'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = 'http://fayesrvr.herokuapp.com'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        render :text => '', :content_type => 'text/plain'
      end
    end
  end

  if Rails.env.production?
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = 'http://fsrvrproduction.herokuapp.com'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = 'http://fsrvrproduction.herokuapp.com'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.
    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = 'http://fsrvrproduction.herokuapp.com'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = 'http://fsrvrproduction.herokuapp.com'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        render :text => '', :content_type => 'text/plain'
      end
    end
  end

  def after_sign_in_path_for(resource)
    if !params[:lesson_id]
      root_path
    else
      lesson_path(params[:lesson_id])
    end
  end

  #PRODUCTION FAYE: : http://fsrvrproduction.herokuapp.com
  #STAGING FAYE:  http://fayesrvr.herokuapp.com

 # before_filter :miniprofiler

 #  private
 #  def miniprofiler
 #    Rack::MiniProfiler.authorize_request
 #  end

  def mailitnow
    WeeklyMailer.weekly_top_stories.deliver
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)  do |u|
      u.permit(:email, :password, :password_confirmation, :remember_me, :superhero_power, :team, :skype, :gmail, :instagram, :angellist, :dribbble, :github,
      :bio, :city, :country, :facebook, :first_name, :last_name, :linkedin, :program, :state, :street_address, :twitter, :zip, :online, :employment,
      :latitude, :longitude, :eventReminder,
      :avatar, :tag_list, :ncounter, :pcounter,
      :name, :skill_ids)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :remember_me, :superhero_power, :team, :skype, :gmail, :instagram, :angellist, :dribbble, :github,
      :bio, :city, :country, :facebook, :first_name, :last_name, :linkedin, :program, :state, :street_address, :twitter, :zip, :online, :employment,
      :latitude, :longitude, :eventReminder,
      :avatar, :tag_list, :ncounter, :pcounter,
      :name, :skill_ids,:current_password)
    end

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password)
    end
  end

  def sidebarindex
    @activity_feeds =  ActivityFeed.all
    @activity_feeds = ActivityFeed.page(params[:page]).per(10).order("created_at desc")
    respond_to do |format|
      format.js
      format.html
    end
  end

  def set_device_type #allows use of @browser.mobile? in views
    @mobile = true if browser.mobile?
  end

  def set_meta_tags
    @title = "Courses - DraperTV"
    @meta_description = "Learn about startups, entrepreneurship, and business in Silicon Valley from DraperTV. Watch videos from top Draper University speakers such as Elon Musk, Tony Hsieh, Michelle Phan, and Nate Blecharczyk."
  end


  def track_activity_feed(tobetrackable, action = params[:action])
    current_user.activity_feeds.create! action: action, tobetrackable: tobetrackable
  end

  private
  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end

  private
  
  def must_be_admin
    unless current_user && current_user.role == "admin"
      redirect_to root_path
    end
  end

end

