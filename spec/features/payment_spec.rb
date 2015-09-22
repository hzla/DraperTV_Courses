require 'spec_helper'

feature "payment" do 

	before :each do 
		@user = create :user
		visit new_user_session_path
	    fill_in 'user_email', :with => 'email@email.com'
	    fill_in 'user_password', :with => 'password'
	    click_button "SIGN IN"
	end

	scenario 'make payment with valid credit card' do 
		click_link 'GET MEMBERSHIP'
		fill_in 'full-name', with: "Test Name"
		fill_in 'email', with: 'email@example.com'
		fill_in 'card-number', with: '4242424242424242'
		fill_in 'exp-month', with: '01'
		fill_in 'exp-year', with: 20
		fill_in 'cvc', with: '004'
		click_button 'CHECKOUT'

		expect(page).to have_selector('.topics')
	    expect(page).not_to have_selector('.purchase-membership') 
	end

	# scenario 'make payment with invalid credit card' do 
		
	# end
end
