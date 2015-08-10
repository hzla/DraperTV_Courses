class SessionsController < Devise::SessionsController

  def destroy
    session[:user_id] = nil
    super
  end    
end