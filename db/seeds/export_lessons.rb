target  = "db/seeds/all_lessons.txt"

File.open(target, "w+") do |f|
  Track.all.each do |track|
  	f.puts "Track: #{track.name}"
  	f.puts "Track Order: #{track.order}"
  	track.ordered_lessons.each do |lesson|
  		f.puts "\tLesson Type:: #{lesson.lesson_type}"
  		f.puts "\tBody:: #{lesson.body}"
  		f.puts "\tDescription:: #{lesson.description}"
  		f.puts "\tVideo Uid:: #{lesson.video_uid}" if lesson.video_uid
  		f.puts "\tVideo Title:: #{lesson.video_title}" if lesson.video_title
  		f.puts "\tVideo Author:: #{lesson.video_author}" if lesson.video_author
  		f.puts "\n"
  	end
  end
end