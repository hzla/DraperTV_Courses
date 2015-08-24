class AuthsController < ApplicationController
  include ApplicationHelper
  
  def facebook_create
      auth_hash = request.env['omniauth.auth']
      auth = Authorization.find_by_uid auth_hash['uid']
      if auth
        session[:user_id] = auth.user.id
        if !current_user.email
          current_user.update_attributes email: auth_hash["extra"]["raw_info"]["email"]
        end
        if !current_user.profile_pic_url
          current_user.update_attributes profile_pic_url: auth_hash["extra"]["raw_info"]["image"]
        end
        sign_in current_user
        if session[:resource_id]
          redirect_to "/#{session[:resource_type].pluralize}/#{session[:resource_id]}"
          session[:resource_id] = nil
          return
        end
        redirect_to root_path(sign_in: true) and return
      else #create new user if not authorized
        user = User.create_with_facebook auth_hash
        session[:user_id] = user.id 
        sign_in current_user
        if session[:resource_id]
          redirect_to "/#{session[:resource_type].pluralize}/#{session[:resource_id]}"
          session[:resource_id] = nil
          return
        end
        redirect_to root_path
      end
  end

end
