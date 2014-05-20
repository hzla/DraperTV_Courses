class AssignmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

	def index
		@assignments = Assignment.all
	end

	def show
		@assignment = Assignment.find(params[:id])
    @commentable = @assignment
    @comments = @commentable.user_comments.order('created_at desc')
    @comment = UserComment.new
    @user_assignment = @assignment.user_assignments.where(:user_id => current_user[:id])
    @user = current_user
    @completed = UserAssignment.where(:assignment_id => @assignment.id).where("rating is not null").where.not(user_id: current_user.id)

		if @assignment.category == "video" or @assignment.category == "reading" or @assignment.category == "founder"
		  oembed = "http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/" + @assignment.vimeo_url + '&autoplay=1'
    	puts (Curl::Easy.perform(oembed).body_str)["html"]
    	@video_embed = JSON.parse(Curl::Easy.perform(oembed).body_str)["html"]
    end

    if @assignment.survey
    	@attempt = @assignment.survey.attempts.new
	    # build a number of possible answers equal to the number of options
	    @assignment.survey.questions.size.times { @attempt.answers.build }

      if @assignment.survey.avaliable_for_participant?(current_user)
      else
        @quiz_high_score =  @assignment.survey.attempts.for_participant(current_user).high_score
        @quiz_total_questions = @assignment.survey.questions.count
        @quiz_ratio = (@quiz_high_score.to_f / @quiz_total_questions * 100).to_i
      end
  	end

    if @assignment.user_assignments.where(:user_id => current_user[:id]).count == 0
      if @assignment.category == "video" or @assignment.category == "founder"
        @user_assignment = @assignment.user_assignments.create(
          :assignment_id => @assignment.id,
          :user_id => current_user[:id],
          :point_value => 0
        )
      elsif @assignment.category == "milestone"
        @user_assignment = @assignment.user_assignments.create(
          :assignment_id => @assignment.id,
          :user_id => current_user[:id],
          :point_value => 0
        )

      elsif @assignment.category == "upload"
         @user_assignment = @assignment.user_assignments.create(
          :assignment_id => @assignment.id,
          :user_id => current_user[:id],
          :point_value => 0
        )

      elsif @assignment.category == "quiz"
        @user_assignment = @assignment.user_assignments.create(
          :assignment_id => @assignment.id,
          :user_id => current_user[:id],
          :point_value => 0
        )

       else
         @user_assignment = @assignment.user_assignments.create(
          :assignment_id => @assignment.id,
          :user_id => current_user[:id],
          :point_value => 10,
          :complete => true
          )
          track_activity_feed @user_assignment
       end

      @user.update_column(:pcounter, UserAssignment.where(:user_id => current_user[:id]).sum('point_value'))

      begin
      PrivatePub.publish_to("/layouts/points",
        "$('.pcounter p').text(<%= current_user.pcounter %>);")
      rescue
      end
    end
	end

  def update
    @assignment = Assignment.find params[:id]
    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to @assignment }
        format.json { respond_with_bip(@assignment) }
      else
        format.html { redirect_to :back, :notice => 'Something went wrong'}
      end
    end
  end

  def quiz_save_attempt
    @assignment = Assignment.find params[:id]
    @attempt = @assignment.survey.attempts.new(params[:survey_attempt])

      # ensure that current user is assigned with this attempt
      @attempt.participant = current_user

      if @attempt.valid? and @attempt.save
        @assignment.user_assignments.first.update_attribute(:point_value, 200)
        current_user.update_attribute(:pcounter, UserAssignment.where(:user_id => current_user[:id]).sum('point_value'))
        redirect_to assignment_path
      else
       render :action => :show
      end

      # render :action => :show unless @attempt.valid? and @attempt.save
  end

end

#raise Exception