describe Announcement do 
	before :each do 
		Time.stubs(:now).returns(Time.mktime(2015,9,1,12))
	end


	describe 'Announcement#date_today' do 
		it "formats todays date" do 
			expect(Announcement.date_today).to eq("September 1, 2015")
		end
	end

	describe "Announcement#today" do

		it "retrieves today's announcements" do
			today_announcement = create :announcement, created_at: Time.now
			tmr_announcement = create :announcement, created_at: Time.now + 1.day  
			expect(Announcement.today.first).to eq(today_announcement)
		end

		it "does not retrieve announcements in the past 24 hours that are not on the same date as today" do 
			today_announcement = create :announcement, created_at: Time.now - 13.hours
			expect(Announcement.today.first).to be nil
		end
	end

	describe 'Announcement#formatted_archived' do 

		it 'formats archived announcements' do 
			today_announcement = create :announcement, archived: true, created_at: Time.now
			tmr_announcement = create :announcement, archived: true, created_at: Time.now - 1.day
			expect(Announcement.formatted_archived).to eq({"September 1, 2015" =>[today_announcement], "August 31, 2015"=>[tmr_announcement]})
		end

	end
end