class MessagesController < ApplicationController
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