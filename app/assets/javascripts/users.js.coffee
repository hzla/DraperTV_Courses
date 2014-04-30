jQuery ->
        isScrolledIntoView = (elem) ->
                docViewTop = $(window).scrollTop()
                docViewBottom = docViewTop + $(window).height()
                elemTop = $(elem).offset().top
                elemBottom = elemTop + $(elem).height()
                (elemTop >= docViewTop) && (elemTop <= docViewBottom)

        if $('.pagination').length
                $(window).scroll ->
                        url = $('.pagination .next a').attr('href')
                        if url && isScrolledIntoView('.pagination')
                                $('.pagination').text('Fetching more...')
                                $.getScript(url)

                $(window).scroll()


jQuery ->
        minimized_elements = $("p.minimize")
        minimize_character_count = 210

        minimized_elements.each ->
                t = $(this).text()
                return  if t.length < minimize_character_count
                $(this).html t.slice(0, minimize_character_count) + "<span>... </span><a href=\"#\" class=\"more\">More</a>" + "<span style=\"display:none;\">" + t.slice(minimize_character_count, t.length) + " <a href=\"#\" class=\"less\">Less</a></span>"
                return

        $("a.more", minimized_elements).click (event) ->
                event.preventDefault()
                $(this).hide().prev().hide()
                $(this).next().show()
                return

        $("a.less", minimized_elements).click (event) ->
                event.preventDefault()
                $(this).parent().hide().prev().show().prev().show()
                return

        return
