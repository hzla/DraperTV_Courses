require 'spec_helper'

describe Ama do 

	before :each do 
		@past_ama = create :past_ama
		@upcoming_ama = create :upcoming_ama
	end

	describe "sorting by start_date: " do 
		it 'Ama#past' do
			expect(Ama.past.first).to eq(@past_ama)
		end

		it 'Ama#upcoming' do 
			expect(Ama.upcoming.first).to eq(@upcoming_ama)
		end

		it 'Ama#is_past?' do 
			expect(@past_ama.is_past?).to be true
		end

		it 'Ama#is_upcoming?' do 
			expect(@upcoming_ama.is_upcoming?).to be true
		end
	end

	describe "date formatting: " do 

		context "Ama#elapsed_time" do
			it 'an ama that happened less than an hour ago' do 
				expect(create(:past_ama, start_date: Time.now - 30.minutes).elapsed_time).to eq("30 minutes ago")
			end

			it 'an ama that happened less than a day ago' do 
				expect(create(:past_ama, start_date: Time.now - 12.hours).elapsed_time).to eq("12 hours ago")
			end
		end

		context "Ama#formatted_date" do 
			before :each do 
				Time.stubs(:now).returns(Time.mktime(2015,9,1,12))
			end

			context "an ama that takes place today" do 
				it "that has already past" do 
					ama = create(:past_ama, start_date: Time.now - 10.minutes)
					expect(ama.formatted_start_date).to eq(ama.elapsed_time)
				end

				it "that is upcoming" do 
					ama = create(:upcoming_ama, start_date: Time.now + 10.minutes)
					expect(ama.formatted_start_date).to eq("Today at 12:10 pm PST")
				end
			end

			context "an ama that takes place tomorrow" do 
				it "exactly one day from now" do 
					ama = create(:upcoming_ama, start_date: Time.now + 1.day)
					expect(ama.formatted_start_date).to eq("Tomorrow at 12:00 pm PST")
				end

				it "within 24 hours from now" do 
					ama = create(:upcoming_ama, start_date: Time.now + 13.hours)
					expect(ama.formatted_start_date).to eq("Tomorrow at 1:00 am PST")
				end
			end

			it "an ama that takes place after tomorrow" do 
				ama = create(:upcoming_ama, start_date: Time.now + 37.hours)
				expect(ama.formatted_start_date).to eq("1:00am PST - September 3, 2015") 
			end

			it "an ama that takes place yesterday" do 
				ama = create(:past_ama, start_date: Time.now - 25.hours)
				expect(ama.formatted_start_date).to eq("1 day ago")
			end

			it "an ama that takes place before yesterday" do 
				ama = create(:past_ama, start_date: Time.now - 2.days)
				expect(ama.formatted_start_date).to eq("2 days ago")
			end
		end
	end
end