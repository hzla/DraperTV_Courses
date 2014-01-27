class ApplicationController < ActionController::Base

  protect_from_forgery
  #before_filter :cors_preflight_check
  #after_filter :cors_set_access_control_headers
  # For all responses in this controller, return the CORS access control headers.
  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = 'http://aqueous-caverns-4317.herokuapp.com/faye'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Request-Method'] = 'http://aqueous-caverns-4317.herokuapp.com/faye'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  # end
  # # If this is a preflight OPTIONS request, then short-circuit the
  # # request, return only the necessary headers and return an empty
  # # text/plain.
  # def cors_preflight_check
  #   if request.method == :options
  #     headers['Access-Control-Allow-Origin'] = 'http://aqueous-caverns-4317.herokuapp.com/faye'
  #     headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #     headers['Access-Control-Request-Method'] = 'http://aqueous-caverns-4317.herokuapp.com/faye'
  #     headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  #     render :text => '', :content_type => 'text/plain'
  #   end
  # end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://ancient-fjord-6459.herokuapp.com/faye'
    headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  #PRODUCTION FAYE: http://ancient-fjord-6459.herokuapp.com/faye
  #STAGING FAYE: http://aqueous-caverns-4317.herokuapp.com/faye

  private
     def track_activity(trackable, action = params[:action])
       current_user.activities.create! action: action, trackable: trackable
     end


  
  

end

