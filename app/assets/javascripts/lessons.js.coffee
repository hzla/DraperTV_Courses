Lesson =
	init: ->
		$('body').on 'click', '.bar-header', @toggleBarItems
		$('body').on 'click', '.plan', @selectPlan
		$('body').on 'click', '.comment-open', @openComment
		$('body').on 'click', '.comment-close', @closeComment
		$("body").on 'keypress', '.comment-children, .comment-body', @submitFormOnEnter

	submitFormOnEnter: (e) ->
		if e.which == 13
			e.preventDefault()
			$(@).parents('form').submit()

	openComment: ->
		$(@).parents('.comment').find('.comment-close, .comment-pic, .comment-body, .comment-vote-container, .comment-text-vote').toggleClass('hidden')
		$(@).parents('.comment').toggleClass('collapsed')
		$(@).parents('.comment').next().removeClass('hidden')
		$(@).addClass('hidden')

	closeComment: ->
		$(@).parents('.comment').find('.comment-open, .comment-pic, .comment-body, .comment-vote-container, .comment-text-vote').toggleClass('hidden')
		$(@).parents('.comment').toggleClass('collapsed')
		$(@).parents('.comment').next().addClass('hidden')
		$(@).addClass('hidden')


	selectPlan: ->
		$('.plan-icon').addClass('hidden')
		$('.plan-icon.unselected').removeClass('hidden')
		$(@).find('.plan-icon.unselected').addClass('hidden')
		$(@).find('.plan-icon.selected').removeClass('hidden')
		$('#plan-input').val $(@).attr('data-plan')

	toggleBarItems: ->
		$(@).parent().find('.bar-item').toggle()
		

ready = ->
	Lesson.init()
$(document).ready ready
$(document).on 'page:load', ready

