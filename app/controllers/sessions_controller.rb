class SessionsController < Devise::SessionsController

  def destroy
    session[:user_id] = nil
    super
  end 

  def new
  	session[:resource_id] = params[:resource_id]
    session[:resource_type] = params[:resource_type]
    super
  end   
end