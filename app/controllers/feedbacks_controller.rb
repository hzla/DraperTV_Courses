class FeedbacksController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @app }
    end
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @user = current_user

    respond_to do |format|
      if @feedback.save
        FeedbackMailer.feedback_send(@feedback, @user).deliver
        format.html { redirect_to feedbacks_path, notice: 'Thanks for your feedback, hero!' }
        #format.json { render json: @app, status: :created, location: @app }
      else
        format.html { render action: "new" }
        #format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end
end
