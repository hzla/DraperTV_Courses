class WeeklyMailer < ActionMailer::Base
  ### set default e-mail address

default   to: 'yad.faiq@gmail.com',
          from: 'draperuniversityonline@gmail.com'

    def weekly_top_stories
      @posts = Post.all
      @users =  User.all
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
