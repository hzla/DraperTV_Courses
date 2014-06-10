module MailerHelper
  def track(name, email)
    SentEmail.create!(:name => name, :email => email, :sent => DateTime.now)
    url = "#{root_path(:only_path => false)}email/track/#{Base64.encode64("name=#{name}&email=#{email}")}.png"
    raw("<img src=\"#{url}\" alt=\"\" width=\"1\" height=\"1\">")
  end
end