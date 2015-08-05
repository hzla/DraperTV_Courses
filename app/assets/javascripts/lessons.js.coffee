Lesson =
	init: ->
		$('body').on 'click', '.bar-header', @toggleBarItems
		$('body').on 'click', '.plan', @selectPlan
		$('body').on 'click', '.comment-open', @openComment
		$('body').on 'click', '.comment-close', @closeComment
		$("body").on 'keypress', '.comment-children, .comment-body, .chat-comment-body', @submitFormOnEnter
		$('body').on 'ajax:success', '.chat-box-container .new_comment', @addComment
		$('body').on 'ajax:success', '.main-comment', @addMainComment
		$('body').on 'ajax:success', '.comment-children .new_comment', @addChildComment
		$('body').on 'ajax:success', '.upvote-link', @updateUpvotes
		$('body').on 'click', '.reply-comment', @showCommentReplyForm
		@scrollToLesson()

	scrollToLesson: ->
		$('#side-nav').scrollTo('.bar-item.current')

	showCommentReplyForm: ->
		$(@).parents('.comment').next().find('form').toggleClass('hidden')
		$(@).hide()


	updateUpvotes: (event, data) ->
		value = data.value
		voteCount = $(@).parents('.comment-vote-container').find('.vote-count')
		voteCount.text value
		toShow = $(@).find '.hidden'
		$(@).children().addClass 'hidden'
		toShow.removeClass 'hidden'
		$(@).parents('.comment-vote-container').toggleClass 'upvoted'

	addComment: (event, data) ->
		$(@)[0].reset()
		$('.chat-messages').append data
		setTimeout ->
			$('.chat-messages').scrollTop(100000)
		, 100

	addMainComment: (event, data) ->
		$(@)[0].reset()
		$('.comments').prepend data

	addChildComment: (event, data) ->
		$(@)[0].reset()
		$(data).insertBefore(@)
		# $(@).parents('.comment-children').append data

	submitFormOnEnter: (e) ->
		if e.which == 13
			e.preventDefault()
			$(@).parents('form').submit()

	openComment: ->
		$(@).parents('.comment').find('.comment-close, .comment-pic, .comment-body, .comment-vote-container, .comment-text-vote, .reply-comment').toggleClass('hidden')
		$(@).parents('.comment').toggleClass('collapsed')
		$(@).parents('.comment').next().removeClass('hidden')
		$(@).addClass('hidden')

	closeComment: ->
		$(@).parents('.comment').find('.comment-open, .comment-pic, .comment-body, .comment-vote-container, .comment-text-vote, .reply-comment').toggleClass('hidden')
		$(@).parents('.comment').toggleClass('collapsed')
		$(@).parents('.comment').next().addClass('hidden')
		$(@).addClass('hidden')


	selectPlan: ->
		$('.plan').removeClass('selected')
		$(@).addClass('selected')
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

