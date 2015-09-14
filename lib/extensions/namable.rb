module Extensions
	module Namable
	  def camel_case_name
	    name.downcase.split(" ").map(&:capitalize).join(" ")
	  end

	  def html_class_name
	    name.downcase.gsub(" ", "-").gsub("&-", "")
	  end

	  def display_name
	    name.downcase.split(" ").map(&:capitalize).join(" ")
	  end
	end
end
		