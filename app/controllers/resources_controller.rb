class ResourcesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @resources = Resource.all
  end
end
