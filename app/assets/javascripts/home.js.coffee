Home =
	init: ->
		$('.tool-tip-icon').click @showToolTip
		$('.tool-tip-okay').click @hideToolTip
		$('body').click @hideAll
		$('.cancel-sub-link').on 'ajax:success', @informUser
		$('.cancel-sub').click @showCancelOverlay
		$(".cancel-overlay").click @closeOverlay
		$(".header-search form").submit @searchDraperTV

	searchDraperTV: (e) ->
		e.preventDefault()
		terms = $(@).find('.search-input').val()
		location.href = "http://www.drapertv.com/searches?terms=#{terms}"


	closeOverlay: (e) ->
		$('.cancel-overlay').hide() if $(e.target).hasClass('cancel-overlay')

	showCancelOverlay: ->
		$(".cancel-overlay").show()

	informUser: (event, data) ->
		$('.cancel-message, .cancel-text').text("")
		$('.cancel-text').text data.message

	showToolTip: (e) ->
		$('.current').removeClass('current')
		$(@).parent().find('.tool-tip').addClass('current')
		$('.tool-tip:not(.current)').hide()
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

