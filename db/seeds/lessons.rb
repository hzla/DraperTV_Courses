Mod.all.each do |mod|
	["watch", "summary", "challenge", "reading list", "reading list", "discussion", "true story" ].each do |type|
		Lesson.create lesson_type: type, description: "How Our Team Lived on %500 a month - David Chen, Strikingly", mod_id: mod.id
	end
end