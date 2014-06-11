class WeeklyMailer < ActionMailer::Base
  ### set default e-mail address
helper :mailer
default   to: 'yad.faiq@gmail.com',
          from: 'info@draperuniversity.com'

    def progress_report_email(user)
      @user = user
      mail( :to => user.email, :subject => "Your Progress Report")
    end

    def weekly_top_stories(user)
      @comments =  UserComment.all
      @comments = @comments.where("created_at > ?", (Date.today - 7.days)).where(:commentable_type => "Post")
      postIds = []
      @comments.each do |comment|
        postIds << comment.commentable_id
      end
      postIds = comment_freq_counter(postIds)
      @posts = postIds.sort_by {|k,v| -v }.first(5).map(&:first)


      @comments =  UserComment.all
      @comments = @comments.where("created_at > ?", (Date.today-7.days))
      userCommentIds = []
      @comments.each do |comment|
        userCommentIds << comment.user_id
      end

      userCommentIds = comment_freq_counter(userCommentIds)
      @topCommenters = userCommentIds.sort_by {|k,v| -v }.first(5).map(&:first)

      @uas =  UserAssignment.all
      @uas = @uas.where("created_at > ?", (Date.today-7.days))
      userAssignmentStudentIds = []
      @uas.each do |ua|
        userAssignmentStudentIds << ua.user_id
      end
      userAssignmentStudentIds = comment_freq_counter(userAssignmentStudentIds)
      @topGeeks = userAssignmentStudentIds.sort_by {|k,v| -v }.first(5).map(&:first)

      @user = user
      mail(
        to: "#{user.full_name} <#{user.email}>",
        subject: "Draper University Weekly Digest",
        from: 'Draper University',
        :date => Time.now,

        :template_path => "weekly_mailer",
        :template_name => "weekly_top_stories"
      )
    end

    # Method to create a hash of PostIDs with Number of Comments in them!
    def comment_freq_counter(ary)
      ary.inject(Hash.new(0)) { |h,e| h[e] += 1; h }.select {
        |k,v| v > 1 }.inject({}) { |r, e| r[e.first] = e.last; r }
    end
    def largest_hash_key(hash)
      hash.max_by{|k,v| v}
    end

end
