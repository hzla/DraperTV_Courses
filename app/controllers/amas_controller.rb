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
    @comments = @ama.comments.includes(:user).where(ancestry: nil, comment_type: "regular").order('created_at desc')
    @chat_comments = @ama.comments.includes(:user).where(comment_type: "chat").order(:created_at)
    if params["sort"] && params["sort"] == "top"      
      @comments = @comments.sort_by {|c| c.get_upvotes.size}.reverse
    end
  end
end
