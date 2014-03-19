class ActivitiesController < ApplicationController
  def index
  	@activities =  Activity.all
    @activities = Activity.page(params[:page]).per(10).order("created_at desc")

    #we will need to find the Post id Through Users relation to the Comments
    #And this is because Activity Track, tracks Users actions, it breaks down from there.
    
  	# @posts = Post.all
  	# @user_comments = UserComment.all
  respond_to do |format|               
    format.js 
    format.html 

  end 
  end

 

end

