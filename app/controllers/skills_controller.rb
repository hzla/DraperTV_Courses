class SkillsController < ApplicationController


  before_filter :authenticate_user!
  def index
    @skills = Skill.all
    respond_to do |format|
      format.html
    end
  end


  def show
    @skill = Skill.find(params[:id])
    respond_to do |format|
      format.html
    end
  end


end
