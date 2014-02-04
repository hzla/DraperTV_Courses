# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

        isScrolledIntoView = (elem) ->
                docViewTop = $(window).scrollTop()
                docViewBottom = docViewTop + $(window).height()
                elemTop = $(elem).offset().top
                elemBottom = elemTop + $(elem).height()
                (elemTop >= docViewTop) && (elemTop <= docViewBottom)

        if $('.nothing').length
                $(window).scroll ->
                        url = $('.nothing .next a').attr('href')
                        if url && isScrolledIntoView('.nothing')
                                $('.nothing').text('Fetching more...')
                                $.getScript(url)
                
                $(window).scroll()