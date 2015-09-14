class AmasController < ApplicationController
  include ApplicationHelper

  def index
    @upcoming_amas = Ama.upcoming 
    @past_amas = Ama.past
    @page = "monthly"
  end

  def show
    @user = current_user
    redirect_to "/users/sign_up?resource_type=ama&resource_id=#{params[:id]}" and return if !@user
    @ama = Ama.find params[:id]

    if !@ama.is_upcoming? #past amas must be paid for
      redirect_to new_charge_path(resource_type: "ama", resource_id: params[:id]) and return if !@user.paid 
    end
    
    @comment = Comment.new
    @comments = @ama.regular_comments
    @chat_comments = @ama.chat_comments
    
    @sort = "date" #add cached upvotes migration to make faster
    if params["sort"] == "top"      
      @comments = @comments.sort_by {|c| c.get_upvotes.size}.reverse
      @sort = "top"
    end
    @user.randomize_color
  end

end
