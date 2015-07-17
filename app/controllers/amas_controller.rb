class AmasController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!

  def index
    @upcoming_amas = Ama.upcoming
    @past_amas = Ama.past
  end

  def show
    @ama = Ama.find params[:id]
    @comment = Comment.new
  end
end
