Lesson.where(lesson_type: "watch").each do |lesson|
	video = HTTParty.get("https://api.vimeo.com/videos/#{lesson.video_uid}", headers: {"Authorization" => "bearer #{ENV['VIMEO_TOKEN']}"})
	response = JSON.parse video.parsed_response
	duration = response['duration']
	minutes = duration / 60
	seconds = duration % 60
	if seconds < 10
		seconds = "0#{seconds}"
	end
	length = "#{minutes}:#{seconds}"
	lesson.update_attributes video_length: length
end

