class WeeklyMailer < ActionMailer::Base

  def progress_report_email(user)
    @user = user
    mail( :to => user.email, :subject => "Your Progress Report")
  end

  def weekly_top_stories
    posts = Post.all
    users =  User.all
    mail(subject: "This Week's Top Discussions")
  end
end
