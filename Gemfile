# Gemfile
source "https://rubygems.org"
ruby '2.0.0'

gem 'rails', '4.2.4'
gem 'nokogiri'
gem 'pg', '~> 0.18.1'
gem 'rails_12factor', group: :production
gem 'delayed_job_active_record'
gem 'devise'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'cancan'
gem 'acts_as_votable', '~> 0.10.0'
gem 'simple_form'
gem 'paperclip', github: 'thoughtbot/paperclip'
gem 'curb'
gem "passenger"
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'ckeditor'
gem 'link_thumbnailer'
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'

# analytics & email
gem 'newrelic_rpm'
gem 'omniauth-facebook', github: "mkdynamic/omniauth-facebook"
gem 'ancestry'
gem 'vimeo'
gem 'sanitize'
gem 'browser'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'compass-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem "ransack"
  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails', "2.3.0"
gem 'jquery-ui-rails'

# Amazon S3 Storage for media files
gem 'aws-sdk', '~> 1.5.7'
gem 'foreman'
gem 'right_aws'

gem 'pry'
gem 'dotenv-rails'

# Development Only
group :development do
  gem 'meta_request'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb' #use Hirb.enable to enable it / text to Column
  gem 'awesome_print', :require => 'ap'
  gem 'wirble'
  gem 'railroady' #run this command: rake diagram:all
  gem "bullet" # it always works unless you remove the initilzer
  gem "reek" # run this : reek .
  gem 'brakeman', :require => false # run this : brakeman [appPath] -o output_file
  gem 'traceroute' # to check unUsed and Unreachable routes >  rake traceroute
  gem 'quiet_assets' #takes away the Asset messages in the Log
  gem 'annotate', ">=2.6.0"
end

# gem 'rack-mini-profiler'
gem 'pg_search'
gem "simple_calendar", "~> 0.1.9"
gem "kaminari"
gem 'populator'
gem 'faker'
gem 'acts-as-taggable-on'
gem 'stripe'
gem 'private_pub'
gem 'httparty'
gem 'jbuilder', '~> 1.2'
gem "formtastic"

#rails Legacy Gems
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'

#Gems related to Mailer (somehow)
gem 'exception_notification'
gem "delayed_job_web", github: "toolmantim/delayed_job_web", branch: "fix-rails-sessions"

#Cache Gems
# gem 'memcachier'
# gem 'dalli'
# gem 'rack-cache'
# gem 'kgio'

gem 'friendly_id', '~> 5.1.0'
group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem "database_cleaner", '1.0.0.RC1'
  gem 'selenium-webdriver'
  gem 'factory_girl'
  gem 'mocha'
  gem 'shoulda-matchers'
end
gem 'httparty'


