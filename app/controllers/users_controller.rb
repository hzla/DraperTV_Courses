class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :http_basic_authentication, :only => :access
  load_and_authorize_resource

  def edit
    @user = current_user
    if params[:code] == "draper"
      session[:user_id] = params[:user]
    end
    @plans = {"Hero" => "HERO ($10/M)", "SuperHero" => "SUPER HERO ($15/M)", "SuperHeroYearly" => "SUPER HERO YEARLY ($90/M)", "Unlimited" => "UNLIMITED", "Trial" => "Trial" }
  end

  def update
    current_user.update_attributes(user_params)
    redirect_to edit_user_path
  end

  def destroy
    if current_user.customer_id
      @customer = Stripe::Customer.retrieve(current_user.customer_id)
      subscription = @customer.subscriptions.each(&:delete)
      current_user.update_attribute :paid, false
      current_user.update_attribute :customer_id, nil
    else
      current_user.update_attributes paid: false
    end
    current_user.destroy
    session[:user_id] = nil
    redirect_to '/logout'
  end

  def user_params
    params.require(:user).permit(:avatar, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name,:current_password, :username, :full_name)
  end
end
