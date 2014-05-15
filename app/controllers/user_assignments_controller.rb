class UserAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @user_assignment = UserAssignment.friendly.find(params[:id])
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
        current_user.update_attribute(:pcounter, UserAssignment.where(:user_id => current_user[:id]).sum('point_value'))
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render }
      end
    end
  end

end