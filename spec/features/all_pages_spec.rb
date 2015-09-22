require 'spec_helper'

feature "all pages" do 

	before :each do 
		@user = create :user
		@topic = create :topic
		@track = create :track, topic_id: @topic.id
		@lesson = create :lesson,  track_id: @track.id, lesson_type: "watch"
		@ama = create :past_ama

		visit new_user_session_path
	    fill_in 'user_email', :with => 'email@email.com'
	    fill_in 'user_password', :with => 'password'
	    click_button "SIGN IN"
	end

	scenario 'go through site' do 
		expect(page).to have_selector('#landing-header')
		find('.topic a').click
		expect(page).to have_selector('#landing-header')
		find('.tracks a').click
		expect(page).to have_selector('#landing-header')
		find('.watch a.lesson-item').click
		expect(page).to have_selector('#landing-header')
		click_link 'COURSES'
		click_link 'LIVE LEARNING'
		expect(page).to have_selector('#landing-header')
		click_link 'CALENDAR'
		expect(page).to have_selector('#landing-header')
		click_link 'GET MEMBERSHIP'
		expect(page).to have_selector('#landing-header')
	end
end