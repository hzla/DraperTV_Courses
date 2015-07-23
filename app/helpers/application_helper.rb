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

	def current_user
		if session[:user_id]
			User.find session[:user_id]
		else
			super
		end
	end

	def broadcast(channel, json)
	  message = {:channel => channel, :data => json, :ext => {:auth_token => FAYE_TOKEN}}
	  uri = URI.parse("http://faye-server-10.herokuapp.com/faye")
	  Net::HTTP.post_form(uri, :message => message.to_json)
	end
end
