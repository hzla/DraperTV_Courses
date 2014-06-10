class CompleteMailer < ActionMailer::Base
  ### set default e-mail address
  default :from => "info@draperuniversity.com"

  def course_complete(user, badge)
    @badge = badge
    @user = user
    @course = Course.find(@badge.course_id)
    mail(
      :to => "kelsey@draperuniversity.com",
      :subject => "Congratulations!",
      :from => 'Draper University',
      :date => Time.now,
      :content_type => "text/html",
      :template_path => "complete_mailer",
      :template_name => "course_complete"
    )
    #mail( :to => "duhonlineapps@gmail.com, applications@draperuniversity.com", :subject => "New Boarding School Application: #{@app.first} #{@app.last}" )
  end
end
