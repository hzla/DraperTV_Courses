class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end

after_filter :set_access_control_headers

def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "http://tranquil-castle-6757.herokuapp.com/faye"
    headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
end

end
