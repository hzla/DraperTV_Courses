class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
    @messages = Message.all
    @message = Message.new
    @users = User.all
    @user = current_user
  end

  def create
    @message = Message.create!(params[:message])
    PrivatePub.publish_to("/messages/ester", message: @message)
  end
end