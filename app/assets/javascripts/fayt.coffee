$ -> $("[data-fayt]").fayt()

$.fn.fayt = ->
  $container = $(this)
  $form = $container.find("[data-fayt-form]")
  $query = $form.find("[data-fayt-query]")
  $results = $container.find("[data-fayt-results]")

  $query.on('keyup', _.debounce( ->
    $.ajax(
      url: $form.attr("action")
      type: $form.attr("method")
      data:
        query: $query.val()
        partial: true
    ).done( (data, status, xhr) ->
      $results.html(data)
    )
  , 300))
  
