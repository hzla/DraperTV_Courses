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
    @comments = @ama.regular_comments
    @chat_comments = @ama.chat_comments
    if params["sort"] == "top"      
      @comments = @comments.sort_by {|c| c.get_upvotes.size}.reverse
    end
  end
end
