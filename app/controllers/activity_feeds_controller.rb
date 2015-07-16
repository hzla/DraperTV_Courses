class ActivityFeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
        format.js
        format.html
    end
  end

end
