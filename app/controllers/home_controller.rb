class HomeController < ApplicationController
  def index
    if user_signed_in?
      #redirect_to posts_path, :use_rails_ajax => false
      redirect_to logout_path, :use_rails_ajax => false
    else
      redirect_to login_path, :use_rails_ajax => false
    end
  end
end
