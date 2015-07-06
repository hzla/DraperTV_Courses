["VISION", "STARTING UP", "FUNDRAISING", "PRODUCT", "MARKETING", "SALES", "HIRING", "BIZ & FINANCE", "LEGAL"].each_with_index do |name, i|
	Topic.create name: name, icon: name.downcase.gsub(" ", "-") + ".svg" , percentage: 0, order: i + 1
end