class Integer
 
  def to_roman
    result = ""
    number = self
    roman_mapping.keys.each do |divisor|
      quotient, modulus = number.divmod(divisor)
      result << roman_mapping[divisor] * quotient
      number = modulus
    end
    result.downcase
  end
 
  private
 
  def roman_mapping
    {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
  end
end


contents = File.read('db/seeds/attitude.txt').split("\n").compact
currently_seeding_track = nil
currently_seeding_lesson = nil
current_type = nil
tab_counter = 0
video_line_counter = 0


Topic.where(name: "ATTITUDE").first.tracks.map(&:lessons).flatten.select { |l| l.lesson_type != "watch"}.each(&:destroy)
Progress.destroy_all

contents.each do |line|
	if line.include? "Track: "
		currently_seeding_track = Track.find_by_name line.split("Track: ")[-1].upcase
	elsif line.include? "Type: "
		current_type = line.split("Type: ")[-1].downcase.strip
		if current_type == "watch"
			video_line_counter = 1
		else
			video_line_counter = 0
		end
	else
		if currently_seeding_track
			if current_type == "watch"
				if video_line_counter % 3 == 1
					currently_seeding_lesson = Lesson.find_by_video_title line
				elsif video_line_counter % 3 == 2
					if currently_seeding_lesson
						currently_seeding_lesson.update_attributes video_author: line
					end
				else
					if currently_seeding_lesson
						currently_seeding_lesson.update_attributes body: "<p>#{line}</p>"
					end
				end
				video_line_counter += 1
			elsif line.include? "<tab>"
				body_extension = line.gsub("<tab>", "<br><div class='tabbed'>#{tab_counter.to_roman}.</div>")
				body_extension = "<div class='tabbed-section'>" + body_extension + "</div>"
				currently_seeding_lesson.update_attributes body: currently_seeding_lesson.body + body_extension
				tab_counter += 1
			else
				currently_seeding_lesson = Lesson.create lesson_type: current_type, body: "#{line}", track_id: currently_seeding_track.id, description: line, discussion: true
				tab_counter = 1
			end
		end
	end
end

Lesson.where(lesson_type: "tools").update_all discussion: false
Lesson.where(lesson_type: "reading").update_all discussion: false