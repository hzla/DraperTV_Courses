# assumes topics already exist, if not, run rake db:seed:topics first

Track.destroy_all

contents = File.read('db/seeds/tracks.txt').split("\n").compact.reject!(&:empty?)
currently_seeding_topic = nil
order = 0

contents.each do |line|
	if !line.include?("\t")
		currently_seeding_topic = Topic.find_by_name line.rstrip.upcase
		order = 0
	else
		name = line[1..-1].rstrip
		Track.create name: name, topic_id: currently_seeding_topic.id, order: order, icon: name.downcase.gsub(" ", "-") + ".svg"
		order += 1
	end
end