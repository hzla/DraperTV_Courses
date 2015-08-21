Header =
	init: ->
		$('body').on 'click', '.menu', @toggleMenuOnClick
		$('body').on 'click', '.main', @hideMenuOnClick
		$('body').on 'click', '.search', @toggleSearchOnClick
	# 	$('body').on 'click', @revertHeader

	# revertHeader: (e) ->
	# 	$('.menu, .logo, .no-desk form, header > a').toggle()

	toggleSearchOnClick: ->
  		$('.menu, .logo, .no-desk form, header > a').toggle()

 	hideMenuOnClick: ->
  		$('.menu-menu').hide()
  		$('header *').attr('style', '')

 	toggleMenuOnClick: ->
  		$('.menu-menu').toggle()

ready = ->
	Header.init()
$(document).ready ready
$(document).on 'page:load', ready
