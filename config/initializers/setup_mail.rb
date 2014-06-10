ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "draperuniversityonline",
  :password             => "123urock!",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
if Rails.env.development?
		ActionMailer::Base.default_url_options[:host] = "http://localhost:3000"
elsif Rails.env.staging?
		ActionMailer::Base.default_url_options[:host] = "http://staging-online.draperuniversity.com/"
elsif Rails.env.production?
		ActionMailer::Base.default_url_options[:host] = "http://draperuniversity.com/"
end