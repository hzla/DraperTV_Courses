class WeeklyMailer < ActionMailer::Base
  ### set default e-mail address

default   to: 'yad.faiq@gmail.com',
          from: 'draperuniversityonline@gmail.com'

    def progress_report_email(user)
      @user = user
      mail( :to => user.email, :subject => "Your Progress Report")
    end
    def weekly_top_stories
      @comments =  UserComment.all
      @comments = @comments.where("created_at > ?", (Date.today-7.days)).where(:commentable_type => "Post")
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

      mail(subject: "This Week's Top Discussions")

    end
  # def application_confirmation(app, file = nil)
  #   @app = app

  #   unless file.nil?
  #     attachments[file.original_filename] = file.read
  #   end

  #   # unless file.nil?
  #   #   part :content_type => "multipart/mixed" do |p|
  #   #     p.attachment :content_type => file.content_type,
  # #                    :file_name => file.original_filename,
  # #                    :transfer_encoding => "Base64",
  # #                    :body => file.read
  # #     end
  #   # end

  #   mail( :to => "duhonlineapps@gmail.com, applications@draperuniversity.com", :subject => "New Boarding School Application: #{@app.first} #{@app.last}" )
  # end

end
