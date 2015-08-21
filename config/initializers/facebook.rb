require 'dotenv'
Dotenv.load

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'], {scope: "email"}
	p "this has been loaded"
end

