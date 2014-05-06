module ApplicationHelper
	def present(object, klass = nil)
	    klass ||= "#{object.class}Presenter".constantize
	    presenter = klass.new(object, self)
	    yield presenter if block_given?
	    presenter
	end

	  def sortable(column, title = nil)
	    title ||= column.titleize
	    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
	    link_to title, :sort => column, :direction => direction
	  end

	def flash_class(type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-success"
		else
			""
		end
	end
end
