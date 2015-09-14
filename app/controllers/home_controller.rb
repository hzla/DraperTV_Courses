class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to feed_path, :use_rails_ajax => false
    else
      redirect_to login_path, :use_rails_ajax => false
    end
  end

  def terms
  end

  def privacy_policy
  end
end
