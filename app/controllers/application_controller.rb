class ApplicationController < ActionController::Base
     #after_filter :set_access_control_headers

   protect_from_forgery

private
   def track_activity(trackable, action = params[:action])
     current_user.activities.create! action: action, trackable: trackable
   end


end

