class ActivitiesController < ApplicationController
  def index
  	@activities =  Activity.all
    @activities = Activity.order("created_at desc")

    #we will need to find the Post id Through Users relation to the Comments
    #And this is because Activity Track, tracks Users actions, it breaks down from there.
    
  	@posts = Post.all
  	@user_comments = UserComment.all
  respond_to do |format|               
    format.js 
    format.html 

  end 
  end

 def display
	@activities =  Activity.all
    @activities = Activity.order("created_at desc")

    #we will need to find the Post id Through Users relation to the Comments
    #And this is because Activity Track, tracks Users actions, it breaks down from there.
    
  	@posts = Post.all
  	@user_comments = UserComment.all 	
  respond_to do |format|               
    format.js 
  end        
 end


end

