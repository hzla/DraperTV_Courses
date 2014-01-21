class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end

	after_filter headers['Access-Control-Allow-Origin'] = "http://tranquil-castle-6757.herokuapp.com/faye"
end
