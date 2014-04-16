class ReminderMailer < ActionMailer::Base

  default 	to: 'yad.faiq@gmail.com',
			bcc: Proc.new { User.where(:eventReminder => "true").pluck(:email) },
			from: 'draperuniversityonline@gmail.com'
		def events_reminder(event)
			@event =  event
			mail(subject: "Event Reminder: #{@event.name}")
		end
end
