module Extensions
	module Iconable
	    def done_icon
		    done = icon.gsub(".svg", "done.svg") 
		end

		def icon
		   	"icons/" + super
		end
	end
end
		