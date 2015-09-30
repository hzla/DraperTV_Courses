Home =
	init: ->
		$('body').on 'click', '.tool-tip-icon', @showToolTip
		$('body').on 'click', '.tool-tip-okay', @hideToolTip
		$('body').click @hideAll
		$('.cancel-sub-link').on 'ajax:success', @informUser
		$('.cancel-sub').click @showCancelOverlay
		$(".cancel-overlay").click @closeOverlay
		$(".header-search form").submit @searchDraperTV
		$(document).scroll @adjustRightColumn

	adjustRightColumn: ->
		offset = 110 - $('body').scrollTop()
		$('.column-right').css('top', "#{offset}px")
		$('.column-right').css('height', "calc(100vh - #{offset}px)")

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

		if $('.tool-tip.current:visible').length > 0
			$('.tool-tip.current:visible').hide()
		else
			$(@).parent().find('.tool-tip').show()
		
	hideToolTip: -> 
		$(@).parents('.tool-tip').hide()

	hideAll: (e) ->
		if $(e.target).parents('.tool-tip').length < 1 && !$(e.target).hasClass("tool-tip-icon") && !$(e.target).hasClass('tool-tip')
			$('.tool-tip').hide()

ready = ->
	Home.init()
$(document).ready ready
# $(document).on 'page:load', ready

