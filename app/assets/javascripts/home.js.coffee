Home =
	init: ->
		$('.side-info-icon, .lesson-info-icon').click @showToolTip
		$('.tool-tip-okay').click @hideToolTip

	showToolTip: ->
		$(@).parent().find('.tool-tip').show()

	hideToolTip: -> 
		$(@).parents('.tool-tip').hide()



ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready

