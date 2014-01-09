class BucketlistsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def new
  end

  # POST /bucketlist
  # POST /bucketlist.json
  def create
    @bucketlist = Bucketlist.new(params[:user_id])
  end

  def update
    @bucketlist = Bucketlist.find(params[:id])
  end

  def destroy
  end

  def index
    @bucketlists = Bucketlists.all
  end

  def show
    @bucketlist = Bucketlist.find(params[:user_id])
  end
end
