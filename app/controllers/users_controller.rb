class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :http_basic_authentication, :only => :access
  load_and_authorize_resource

  def edit
    @user = current_user
    if params[:code] == "draper"
      session[:user_id] = params[:user]
    end
    @plans = {"Hero" => "HERO ($10/M)", "SuperHero" => "SUPER HERO ($15/M)", "SuperHeroYearly" => "SUPER HERO YEARLY ($90/M)", "Unlimited" => "UNLIMITED" }
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to edit_user_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, 
      :bio, :city, :country, :facebook, :first_name, :last_name, :linkedin, :program, :state, :street_address, :twitter, :zip, :online, :employment,
      :latitude, :longitude, :eventReminder,
      :avatar, :tag_list, :ncounter, :pcounter,
      :name, :skill_ids,:current_password)
  end
end
