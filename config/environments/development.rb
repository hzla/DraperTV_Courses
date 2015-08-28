OnlineSchool::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.eager_load = true
  config.log_tags = [:remote_ip, lambda { |req| Time.now }]

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = false
  config.action_mailer.default_url_options = { :host => 'localhost' }
  # config.action_mailer.delivery_method = :smtp
  #     ActionMailer::Base.smtp_settings = {
  #       :address              => "smtp.gmail.com",
  #       :port                 => 587,
  #       :domain               => "gmail.com",
  #       :user_name            => "draperuniversityonline",
  #       :password             => "123urock!",
  #       :authentication       => "plain",
  #       :enable_starttls_auto => true
  #     }
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.cache_store = :dalli_store

  Paperclip.options[:command_path] = "/usr/local/bin/"

  # WS.config(:access_key_id => 'AWS_ACCESS_KEY_ID', :secret_access_key => 'AWS_SECRET_ACCESS_KEY')

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }



end
