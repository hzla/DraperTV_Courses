class UserAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
    #@user_assignment = UserAssignment.friendly.find(params[:id])
    @user_assignment = UserAssignment.find(params[:id])
    @commentable = @user_assignment
    @comments = @commentable.user_comments.order(:created_at)
    @comment = UserComment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_assignment }
    end
  end

  def edit
    @user_assignment = UserAssignment.find(params[:id])
    @user = UserAssignment.where(:user_id => current_user[:id])
  end

  def update
    @user_assignment = UserAssignment.find(params[:id])
    respond_to do |format|
      if @user_assignment.update_attributes(params[:user_assignment])
        @assignment = Assignment.where(:id => @user_assignment.assignment_id).first
        if @assignment.category == "video" or @assignment.category == "founder"
            pcalculate(300)
        elsif @assignment.category == "milestone"
            pcalculate(300)
        elsif @assignment.category == "upload"
            pcalculate(500)
        elsif @assignment.category == "quiz"
            pcalculate(100)
        else
        end
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render }
      end
    end
  end

end