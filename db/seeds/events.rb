contents = File.read('db/seeds/events.txt').split("\n").compact
currently_seeding_topic = nil

Event.destroy_all

year = 2015

contents.each do |line|
	date = line.split(",")[0]
	name = line.split(",")[-1].strip
	Event.create start_time: date, name: name
end
