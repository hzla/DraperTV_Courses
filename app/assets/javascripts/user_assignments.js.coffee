$ ->
  $("#complete-video-form").submit (e) ->
    if $.trim($("textarea#user_assignment_question_response").val()).length is 0
      $("#warning").text "Your Response Can't Be Empty"
      e.preventDefault()
      false
    else if $.trim($("textarea#user_assignment_question_response").val()).length < 300
      $("#warning").text "Your Response Can't Be Less Than 300 Characters"
      e.preventDefault()
      false
    else if $.trim($("textarea#user_assignment_question_response").val()).length > 300
      frm = $("form#edit_user_assignment_<%= @assignment.id %>")
      jQuery.ajax
        url: frm.attr("action")
        data: frm.serialize()
        complete: ->
          frm.submit()
          return

        dataType: "json"

    return

  return
