user = User.first

Lesson.all.each do |lesson|
	3.times do 
		Comment.create user_id: user.id, lesson_id: lesson.id, body: Faker::Lorem.paragraph
	end
end