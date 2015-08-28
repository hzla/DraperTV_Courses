class UserMailer < ActionMailer::Base
	default :from => "support@drapertv.com"

	def payment_confirmation user
		@user = user
		mail(:to => @user.email, :subject => "#{@user.plan} Membership - Your payment has been received")
	end
end


