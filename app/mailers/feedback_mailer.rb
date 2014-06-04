class FeedbackMailer < ActionMailer::Base
  ### set default e-mail address
  default :from => "info@draperuniversity.com"

  def feedback_send(feedback, user)
    @feedback = feedback
    @user = user
    mail( :to => "kelsey@draperuniversity.com", :subject => "New Alumni Feedback" )
    #mail( :to => "duhonlineapps@gmail.com, applications@draperuniversity.com", :subject => "New Boarding School Application: #{@app.first} #{@app.last}" )
  end
end
