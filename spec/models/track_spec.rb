describe Track do 

	before :each do 
		@track = create :track
	end

	describe '#formatted_watch_time' do 

		it "displays the time in minutes rounded up to the closest 15 minutes for times under an hour" do 
			@track.update_attributes watch_time: 600 #10 minutes
			expect(@track.formatted_watch_time).to eq "15 minutes"
			@track.update_attributes watch_time: 1200 #20 minutes
			expect(@track.formatted_watch_time).to eq "30 minutes"
			@track.update_attributes watch_time: 2400 #40 minutes
			expect(@track.formatted_watch_time).to eq "45 minutes"
		end

		it "display the time in hours rounded to the closest hour for times over an hour" do 
			@track.update_attributes watch_time: 4800
			expect(@track.formatted_watch_time).to eq "1 hour"
			@track.update_attributes watch_time: 7200
			expect(@track.formatted_watch_time).to eq "2 hours"
		end
	end

end