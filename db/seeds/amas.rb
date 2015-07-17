(1..5).each do |n|
	Ama.create title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph * 5, video_url: "asdfasdf", start_date: Time.now + n.months
end


(1..5).each do |n|
	Ama.create title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph * 5, video_url: "asdfasdf", start_date: Time.now - n.months
end