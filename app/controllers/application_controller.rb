class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
  before_filter :configure_permitted_parameters, if: :devise_controller?

  #For all responses in this controller, return the CORS access control headers.
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

  #PRODUCTION FAYE: : http://fsrvrproduction.herokuapp.com
  #STAGING FAYE:  http://fayesrvr.herokuapp.com

 # before_filter :miniprofiler

 #  private
 #  def miniprofiler
 #    Rack::MiniProfiler.authorize_request
 #  end

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


  private
     def track_activity(trackable, action = params[:action])
       current_user.activities.create! action: action, trackable: trackable
     end
end

