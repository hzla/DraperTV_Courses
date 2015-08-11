Home =
	init: ->
		$('.tool-tip-icon').click @showToolTip
		$('.tool-tip-okay').click @hideToolTip
		$('body').click @hideAll

	showToolTip: (e) ->
		$('.tool-tip').hide()
		$(@).parent().find('.tool-tip').toggle()

	hideToolTip: -> 
		$(@).parents('.tool-tip').hide()

	hideAll: (e) ->
		if $(e.target).parents('.tool-tip').length < 1 && !$(e.target).hasClass("tool-tip-icon") && !$(e.target).hasClass('tool-tip')
			$('.tool-tip').hide()




ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready

