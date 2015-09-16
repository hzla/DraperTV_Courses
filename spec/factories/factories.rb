FactoryGirl.define do
  factory :upcoming_ama, :class => "Ama" do 
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    start_date Time.now + 1.day
    video_url "video_url"
    image_url "icons/attitude.svg"
  end

  factory :past_ama, :class => "Ama" do 
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    start_date Time.now - 1.day
    video_url "video_url"
    image_url "icons/attitude.svg"
  end

  factory :announcement do
    body Faker::Lorem.paragraph 
  end

  factory :comment do 
    body Faker::Lorem.paragraph
    association :user, factory: :user
    lesson_id 1
    ama_id 1
  end

  factory :user do 
    email "email@email.com"
    full_name "Full Name"
    username "username"
    password "password"
  end

  factory :lesson do 
    track
    video_uid "123456"
    video_title "Video Title"
    video_author "Video Author"
    body Faker::Lorem.paragraph
    description Faker::Lorem.paragraph
    video_length "5:00"
    slug "video-title"
  end

  factory :track do
    name "Name"
    icon "attitude.svg"
    percent_complete "0"
    topic
    summary Faker::Lorem.paragraph
    video_uid "123456"
    slug "track-name"
  end

  factory :topic do 
    icon "attitude.svg"
    name "Name"
    percent_complete 0
    body Faker::Lorem.paragraph
    summary Faker::Lorem.paragraph
    video_uid "123456"
    slug "topic-name"
    free true
  end

  factory :progress do 
  end
end



