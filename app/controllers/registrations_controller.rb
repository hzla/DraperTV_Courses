class RegistrationsController < Devise::RegistrationsController
  def new
    session[:resource_id] = params[:resource_id]
    session[:resource_type] = params[:resource_type]
    super
  end

  def after_sign_up_path_for(resource)
    if params["resource_id"]
      "/#{params[:resource_type].pluralize}/#{params[:resource_id]}"
    else
      new_charge_path
    end
  end

  def create
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation)}
    super
  end

  def sign_out
    session[:user_id] = nil
    super
  end
end