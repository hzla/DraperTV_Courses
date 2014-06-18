namespace :db do
  desc "Fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    password = "password"
    studentProgram = 'admin'
    #[User].each(&:delete_all)

    User.populate 50 do |person|
      person.first_name    = Faker::Name.first_name
      person.last_name    = Faker::Name.last_name
      person.email   = Faker::Internet.email
      person.encrypted_password = User.new(:password => password).encrypted_password
      person.street_address  = Faker::Address.street_address
      person.city    = Faker::Address.city
      person.country    = Faker::Address.country
      person.latitude    = Faker::Address.latitude
      person.longitude    = Faker::Address.longitude
      person.state   = Faker::Address.state
      person.zip     = Faker::Address.zip_code
      person.online   = studentProgram
      person.pcounter   = 0
      person.role = "boarding"

    end

    # Post.populate 40 do |post|
    #   post.content = Faker::Lorem.sentence
    #   post.title = Faker::Lorem.word
    #   post.category = "General"
    #   post.vote = 1
    #   post.user_id = '1'

    # end

    # UserComment.populate 58 do |comment|
    #   comment.content = Faker::Lorem.sentence
    #   comment.commentable_type = "Post"
    #   comment.commentable_id = "39"
    #   comment.user_id = '1'

    # end
  end
end

