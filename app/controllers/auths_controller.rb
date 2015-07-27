class AuthsController < ApplicationController
  include ApplicationHelper
  
  def facebook_create
      auth_hash = request.env['omniauth.auth']
      auth = Authorization.find_by_uid auth_hash['uid']
      if auth
        session[:user_id] = auth.user.id
        sign_in current_user
        redirect_to root_path(sign_in: true) and return
      else #create new user if not authorized
        user = User.create_with_facebook auth_hash
        session[:user_id] = user.id 
        sign_in current_user
        redirect_to root_path({sign_in: true, sign_up: true}) and return
      end
  end

end
