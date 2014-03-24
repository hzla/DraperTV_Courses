class ReminderMailer < ActionMailer::Base
  default from: "draperuniversityonline@gmail.com"

  def events_reminder(event)
    @event =  event
    mail to: event.user.email, subject: "Reminder"
  end

  # handle_asynchronously :events_reminder, :run_at => Proc.new { 1.minutes.from_now }


  
end
