class ResourcesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @resources = Resource.all
    sidebarindex
  end
end
