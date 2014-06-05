desc "This task is called by the Heroku scheduler add-on"
task :weekly_top_stories => :environment do
  WeeklyMailer.weekly_top_stories
end