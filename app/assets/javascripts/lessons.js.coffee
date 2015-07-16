Lesson =
	init: ->
		$('body').on 'click', '.bar-header', @toggleBarItems
		$('body').on 'click', '.plan', @selectPlan

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
