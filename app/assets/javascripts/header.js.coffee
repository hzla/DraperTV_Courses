Header =
	init: ->
		$('body').on 'click', '.menu', @toggleMenuOnClick
		$('body').on 'click', '.main', @hideMenuOnClick
		$('body').on 'click', '.search', @toggleSearchOnClick
		$(document).scroll @unfreezeColumnMid
		$(document).scroll @adjustShieldOpacity

	adjustShieldOpacity: ->
		$('.shield').css('opacity', $('body').scrollTop() / 60 )

	unfreezeColumnMid: ->
		if $('body').scrollTop() == 60
			$('.column-main').css('overflow', 'scroll')
		else if $('body').scrollTop() == 0
			$('.column-main').css('overflow', 'hidden')
		else

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
# $(document).on 'page:load', ready
