topics = Topic.all
topics.all.each do |topic|
	["THINKING HUGE", "SURVIVAL", "RESOURCEFULNESS"].each_with_index do |name, i|
		Track.create name: name, topic_id: topic, icon: name.downcase.gsub(" ", "-") + ".svg", order: i, topic_id: topic.id
	end
end