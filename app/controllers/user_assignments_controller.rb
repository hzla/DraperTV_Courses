class UserAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user_assignment = UserAssignment.find(params[:id])

     respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_assignment }
    end
  end

  def update
    @user_assignment = UserAssignment.find(params[:id])
    respond_to do |format|
      if @user_assignment.update_attributes(params[:user_assignment])
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render }
      end
    end
  end

  

end