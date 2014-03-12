require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test 'a user should enter a first name' do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test 'a user should enter a last name' do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test 'a user should have an email' do
		user = User.new
		user.email = users(:kelsey).email

		assert !user.save
		assert !user.errors[:email].empty?
	end

	test 'a user should have an email without spaces' do
		user = User.new
		user.email = 'My e-mail with spaces'

		assert !user.save
		assert !user.errors[:email].empty?
		assert !user.errors[:email].include?("must be formatted correctly")
	end
	
end
