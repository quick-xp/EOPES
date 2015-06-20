jQuery ->
  get_crest = ->
    crest_url = $("#crest_url_url").val()
    $.ajax
      url: "crest_debugs/get_crest"
      type: "GET"
      data: crest_url: crest_url

  $("#get_crest_button").on("click",get_crest)