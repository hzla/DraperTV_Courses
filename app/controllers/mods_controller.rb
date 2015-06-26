class ModsController < ApplicationController
  before_filter :authenticate_user!


  def show
    @mod = Mod.find params[:id]
    @lessons = @mod.lessons
    sidebarindex
  end
end
