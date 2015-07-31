Lesson.destroy_all
Progress.destroy_all

contents = File.read('db/seeds/videos.txt').split("\n").compact.reject!(&:empty?)
currently_seeding_track = nil
currently_seeding_lesson = nil
order = 0

contents.each do |line|
	if line.include? "Track: "
		currently_seeding_track = Track.find_by_name line.split("Track: ")[-1]
		p line if currently_seeding_track == nil
	elsif line.include? "Name: "
		if currently_seeding_track
			video_info = line.split("Name: ")[-1]
			video_title = video_info.split("- ")[0]
			video_author = video_info.split("- ")[-1]
			currently_seeding_lesson = Lesson.create description: video_info, lesson_type: "watch", video: true, video_title: video_title, video_author: video_author, track_id: currently_seeding_track.id
		end
	else
		currently_seeding_lesson.update_attributes video_uid: line
	end

end