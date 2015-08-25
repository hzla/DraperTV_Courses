Lesson =
  init: ->
    $('body').on 'change', '#user_avatar', @showPreview

  
  showPreview: ->
    splitFilePath = $(@).val().split("\\")
    imgName = splitFilePath[splitFilePath.length - 1]
    $('.upload-preview').text imgName

                

                

ready = ->
  Lesson.init()
$(document).ready ready
$(document).on 'page:load', ready

