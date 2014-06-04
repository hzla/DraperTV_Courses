class WeeklyMailer < ActionMailer::Base
  ### set default e-mail address

default   to: 'kelsey@draperuniversity.com',
          from: 'draperuniversityonline@gmail.com'

    def progress_report_email(user)
      @user = user
      mail( :to => user.email, :subject => "Your Progress Report")
    end
    def weekly_top_stories
      @comments =  UserComment.all
      @comments = @comments.where("created_at > ?", (Date.today - 7.days)).where(:commentable_type => "Post")
      postIds = []
      @comments.each do |comment|
        postIds << comment.commentable_id
      end
      postIds = comment_freq_counter(postIds)
      @posts = postIds.sort_by {|k,v| -v }.first(5).map(&:first)

      mail(subject: "This Week's Top Discussions")

    end

end
