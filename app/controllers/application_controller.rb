class ApplicationController < ActionController::Base
     after_filter :set_access_control_headers

   protect_from_forgery

private
   def track_activity(trackable, action = params[:action])
     current_user.activities.create! action: action, trackable: trackable
   end

def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://tranquil-castle-6757.herokuapp.com/faye/faye'
    headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
end

end

