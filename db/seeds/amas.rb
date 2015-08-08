# (1..5).each do |n|
# 	Ama.create title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph * 5, video_url: "asdfasdf", start_date: Time.now + n.months
# end


# (1..5).each do |n|
# 	Ama.create title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph * 5, video_url: "asdfasdf", start_date: Time.now - n.months
# end

Ama.destroy_all

Ama.create(title: "How Do I Even Design a Product?", 
description: "Welcome to the first stream in the Day in the Life series! We’re going to walk you through rapid prototyping with a website as an example, and give you an idea of what goes on in a designer’s head as they’re working.",
image_url: "biweekly1.jpg",
video_url: "asdfasdf",
start_date: Time.now + 2.months,
ama_type: "biweekly"
)

Ama.create(title: "The Riskmaster Himself: Tim Draper", 
description: "Ask your questions to some of Silicon Valley’s finest. In our first AMA stream we’ll be joined by Draper University and DFJ founder Tim Draper. We’ll answer your questions about Silicon Valley, venture capital, startups, and more. Stick around for a live chat Q&A with Tim.",
image_url: "monthly1.png",
video_url: "asdfasdf",
start_date: Time.now + 2.months,
ama_type: "monthly")