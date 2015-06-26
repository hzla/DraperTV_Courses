["ATTITUDE", "STARTING UP", "FUNDRAISING", "PRODUCT", "MARKETING", "SALES", "HIRING", "FINANCE", "LEGAL", "AUXILIARY"].each do |name|
	Topic.create name: name, icon: name.downcase.gsub(" ", "-") + ".svg" , percentage: 0
end