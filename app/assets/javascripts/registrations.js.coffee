ready = ->

  jQuery ->
        $('#user_skill_ids').chosen()
        

$(document).ready(ready)
$(document).on('page:load', ready)