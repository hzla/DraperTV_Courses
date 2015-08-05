class AmasController < ApplicationController
  include ApplicationHelper


  def index
    @upcoming_amas = Ama.upcoming "monthly"
    @past_amas = Ama.past "monthly"
    @page = "ama"
  end

  def biweeklies
    @upcoming_amas = Ama.upcoming "biweekly"
    @past_amas = Ama.past "biweekly"
    @page = "ama"
  end

  def show
    redirect_to "/users/sign_up" and return if !current_user
    redirect_to new_charge_path and return if !current_user.paid 
    @ama = Ama.find params[:id]
    @comment = Comment.new
    @comments = @ama.regular_comments
    @chat_comments = @ama.chat_comments
    @sort = "date"
    if params["sort"] == "top"      
      @comments = @comments.sort_by {|c| c.get_upvotes.size}.reverse
      @sort = "top"
    end
    @user = current_user
    @user.randomize_color
  end
end
