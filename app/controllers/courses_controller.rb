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
	end

	def show
		@course = Course.includes(:assignments).friendly.find(params[:id])
		@course.assignments.sort! { |a, b| b.order_id <=> a.order_id }

    if @course.course_complete_for_user?(current_user) == true
      if current_user.badges.exists?(:course_id => @course.id) == true
      else
        @badge = current_user.badges.create(
          :course_id => @course.id,
          :user_id => current_user[:id],
          # :icon => @course.course_icon(:badge),
          :name => @course.title,
          # :vimeo => @course.badge_vimeo
          )
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