contents = File.read('db/seeds/all_lessons.txt').split("\n").compact
currently_seeding_track = nil
currently_seeding_lesson = nil
current_type = nil
tab_counter = 0
video_line_counter = 0


Lesson.destroy_all
Progress.destroy_all



contents.each do |line|
	if line.include? "Track: "
		currently_seeding_track = Track.find_by_name line.split("Track: ")[-1].upcase
		binding.pry if !currently_seeding_track
	elsif line.include? "Track Order: "
		currently_seeding_track.update_attributes order: line.split("Order: ")[-1].to_i
	elsif line.include? "\tLesson Type:: "
		currently_seeding_lesson = Lesson.new lesson_type: line.split("Type:: ")[-1], track_id: currently_seeding_track.id
	elsif line == ""
		p currently_seeding_lesson
	else
		attribute = line.split(":: ")[0].downcase.strip.gsub(" ", "_").to_sym
		value = line.split(":: ")[-1]
		currently_seeding_lesson.update_attributes(attribute => value)
	end
end
