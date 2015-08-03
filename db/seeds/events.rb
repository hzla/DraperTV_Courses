contents = File.read('db/seeds/events.txt').split("\n").compact
currently_seeding_topic = nil
order = 0

year = 2015
5.times do 
	contents.each do |line|
		date = line.split(",")[0] + " #{year}"
		name = line.split(",")[-1].strip
		Event.create start_time: date, name: name
	end
	year += 1
end