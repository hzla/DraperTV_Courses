class CoursesController < ApplicationController
	before_filter :authenticate_user!
  load_and_authorize_resource

	def index
		@courses = Course.all
    @courses.sort! { |a, b| a.start_date <=> b.start_date }
    @current_courses = Course.includes(:assignments).find(:all, :conditions => ['start_date <= ?', DateTime.now])
    @current_courses.sort! { |a, b| a.start_date <=> b.start_date }
    @locked_courses = Course.find(:all, :conditions => ['start_date >= ?', DateTime.now])
    @locked_courses.sort! { |a, b| a.start_date <=> b.start_date }
    sidebarindex
	end

	def show
		@course = Course.includes(:assignments).friendly.find(params[:id])
    @allAssignments = @course.assignments

    if current_user.role == "online"
      @assignments = @allAssignments.where(:req_online => 'required')
      @assignmentsOpt = @allAssignments.where(:req_online => 'optional')
    elsif current_user.role == "boarding"
      @assignments = @allAssignments.where(:req_boarding => 'required')
      @assignmentsOpt = @allAssignments.where(:req_boarding => 'optional')
    else
      @assignments = @allAssignments
      @assignmentsOpt = @allAssignments.limit(0)
    end
		@assignments = @assignments.sort! { |a, b| a.order_id <=> b.order_id }

    if @course.course_complete_for_user?(current_user) == true
      if current_user.badges.exists?(:course_id => @course.id) == true
      else
        #########################
        ### create user badge ###
        #########################
        @badge = current_user.badges.create(
          :course_id => @course.id,
          :user_id => current_user[:id],
          # :icon => @course.course_icon(:badge),
          :name => @course.title,
          # :vimeo => @course.badge_vimeo
        )
        #############################
        ## trigger complete mailer ##
        #############################
        CompleteMailer.course_complete(current_user, @badge).deliver
      end
    end

    #create user_assignment object for uploads
    @course.assignments.each do |assignment|
      if assignment.category == "upload" or assignment.category == "milestone"
        if assignment.user_assignments.where(:user_id => current_user[:id]).count == 0
          @user_assignment = assignment.user_assignments.create(
            :assignment_id => assignment.id,
            :user_id => current_user[:id]
            )
        end
      end
    end

    if @course.intro_vimeo != nil
      oembed = "http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/" + @course.intro_vimeo  + '&maxwidth=500' + '&autoplay=0'
      puts (Curl::Easy.perform(oembed).body_str)["html"]
      @intro_embed = JSON.parse(Curl::Easy.perform(oembed).body_str)["html"]
    end
	end
end