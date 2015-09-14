require 'spec_helper'

feature "Login/Sign in", js: true do 

	before :each do 
		create :user
	end

	scenario 'email password login' do 
		visit new_user_session_path
	    fill_in 'user_email', :with => 'email@email.com'
	    fill_in 'user_password', :with => 'password'
	    click_button "SIGN IN"
	    expect(page).to have_selector('.profile-info', visible: true)
	end

	scenario 'sign up' do 
		visit new_user_registration_path
		fill_in 'user_email', :with => 'email2@email.com'
	    fill_in 'user_password', :with => 'password'
	    fill_in 'user_password_confirmation', :with => 'password'
	    fill_in 'user_username', :with => 'myname'
	    click_button "SIGN UP"
	    expect(page).to have_selector('#plans', visible: true) 
	end
end