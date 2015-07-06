Lesson =
	init: ->
		$('body').on 'click', '.bar-header', @toggleBarItems

	toggleBarItems: ->
		$(@).parent().find('.bar-item').toggle()
		

ready = ->
	Lesson.init()
$(document).ready ready
$(document).on 'page:load', ready
