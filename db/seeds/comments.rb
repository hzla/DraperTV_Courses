user = User.first
Comment.destroy_all


Lesson.all.each do |lesson|
	2.times do 
		comment = Comment.create user_id: user.id, lesson_id: lesson.id, body: Faker::Lorem.paragraph
		2.times do 
			Comment.create user_id: user.id, lesson_id: lesson.id, body: Faker::Lorem.paragraph, parent_id: comment.id
		end
	end
end

Ama.all.each do |lesson|
	2.times do 
		comment = Comment.create user_id: user.id, ama_id: lesson.id, body: Faker::Lorem.paragraph
		2.times do 
			Comment.create user_id: user.id, ama_id: lesson.id, body: Faker::Lorem.paragraph, parent_id: comment.id
		end
		2.times do 
			Comment.create user_id: user.id, ama_id: lesson.id, body: Faker::Lorem.paragraph, comment_type: "chat"
		end
	end
end