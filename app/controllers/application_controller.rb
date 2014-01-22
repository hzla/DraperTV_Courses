class ApplicationController < ActionController::Base

  protect_from_forgery

  private
     def track_activity(trackable, action = params[:action])
       current_user.activities.create! action: action, trackable: trackable
     end

  	headers['Access-Control-Allow-Origin'] = 'http://aqueous-caverns-4317.herokuapp.com/faye'
    headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  	headers['Access-Control-Max-Age'] = "1728000"

end

