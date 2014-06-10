class CompleteMailer < ActionMailer::Base
  ### set default e-mail address
  default :from => "info@draperuniversity.com"

  def course_complete(user, badge)
    @badge = badge
    @user = user
    @course = Course.find(@badge.course_id)
    mail(
      :to => "kelsey@draperuniversity.com, kelseymwhelan@gmail.com",
      :subject => "Congratulations!",
      :from => 'Draper University',
      :date => Time.now,

      :template_path => "complete_mailer",
      :template_name => "course_complete"
    )
  end
end
