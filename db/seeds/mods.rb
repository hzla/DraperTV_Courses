track_ids = Track.where(name: "THINKING HUGE").pluck(:id)

["The 10x Moonshot", "Billion Dollar Problems", "Personal Growth"].each_with_index do |name, i|
	track_ids.each do |id|
		Mod.create name: name, order: i, track_id: id
	end
end

track_ids = Track.where(name: "SURVIVAL").pluck(:id)

["Perseverence","Discipline", "Bootstrapping", "NOT REAL"].each_with_index do |name, i|
	track_ids.each do |id|
		Mod.create name: name, order: i, track_id: id
	end
end

track_ids = Track.where(name: "RESOURCEFULNESS").pluck(:id)

["Hacking", "Hustling", "Negotiation"].each_with_index do |name, i|
	track_ids.each do |id|
		Mod.create name: name, order: i, track_id: id
	end
end