Lesson =
  init: ->
    $('body').on 'change', '#user_avatar', @showPreview
    $('body').on 'submit', '.edit_user', @showUploadingProgress

  
  showPreview: ->
    splitFilePath = $(@).val().split("\\")
    imgName = splitFilePath[splitFilePath.length - 1]
    $('.upload-preview').text imgName


  showUploadingProgress: ->
  	if $('.upload-preview').text() != "No file chosen (limit 10mb)"
  		$('.uploading-progress').show()
  		setInterval ->
  			$('.uploading-progress').text $('.uploading-progress').text() + "."
  		, 500

                

                

ready = ->
  Lesson.init()
$(document).ready ready
$(document).on 'page:load', ready

