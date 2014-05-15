namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'ffaker'
    password = "password"
    studentProgram = 'admin'
    #[User].each(&:delete_all)

    # User.populate 5 do |person|
    #   person.first_name    = Faker::Name.first_name
    #   person.last_name    = Faker::Name.last_name
    #   person.email   = Faker::Internet.email
    #   person.encrypted_password = User.new(:password => password).encrypted_password
    #   person.street_address  = Faker::Address.street_address
    #   person.city    = Faker::Address.city
    #   person.country    = Faker::Address.country
    #   person.latitude    = Faker::Address.latitude
    #   person.longitude    = Faker::Address.longitude
    #   person.state   = Faker::Address.state
    #   person.zip     = Faker::Address.zip_code
    #   person.online   = studentProgram
    #   person.pcounter   = 100

    # end

    Post.populate 50 do |post|
      post.content = Faker::Lorem.sentence
      post.title = Faker::Lorem.word
      post.category = "General"
      post.vote = 1
      post.user_id = '1'

    end

  end
end

