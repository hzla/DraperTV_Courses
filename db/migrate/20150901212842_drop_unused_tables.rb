class DropUnusedTables < ActiveRecord::Migration
  def change
  	drop_table :activities
  	drop_table :activity_feeds
  	drop_table :assignments
  	drop_table :authorships
  	drop_table :badges
  	drop_table :bucketlist_items
  	drop_table :bucketlists
  	drop_table :ckeditor_assets
  	drop_table :courses
  	drop_table :feedbacks
  	drop_table :milestones
  	drop_table :mods
  	drop_table :posts
  	drop_table :resources
  	drop_table :sent_email_opens
  	drop_table :sent_emails
  	drop_table :survey_answers
  	drop_table :survey_attempts
  	drop_table :survey_options
  	drop_table :survey_questions
  	drop_table :survey_surveys
  	drop_table :user_assignments
  	drop_table :videos
  end
end
