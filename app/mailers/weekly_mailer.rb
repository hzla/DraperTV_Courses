class WeeklyMailer < ActionMailer::Base
<<<<<<< HEAD
  ### set default e-mail address

default   to: 'yad.faiq@gmail.com',
          from: 'draperuniversityonline@gmail.com'

    def weekly_top_stories
      @comments =  UserComment.all
      @comments = @comments.where("created_at > ?", (Date.today-7.days)).where(:commentable_type => "Post")
      postIds = []
      @comments.each do |comment|
        postIds << comment.commentable_id
      end
      postIds = comment_freq_counter(postIds)
      postIds = postIds.sort_by {|k,v| v}.reverse
      postIds = postIds.map { |key, value| key }
      @posts = Post.find(postIds.keys)

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
=======
  def progress_report_email(user)
    @user = user
    mail( :to => user.email, :subject => "Your Progress Report")
  end

  def weekly_top_stories
    posts = Post.all
    users =  User.all
    mail(subject: "This Week's Top Discussions")
  end
>>>>>>> 1037c1d5cf66a7e5ddfa8ea06698c211e09e366d
end
