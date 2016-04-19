$ ->
  $('[data-show-if-checked]').each ->
    $input = $("input[name=\"#{$(@).data('show-if-checked')}\"][type=checkbox]")

    $input.on 'click', =>
      if $input.is(':checked') then $(@).show() else $(@).hide()
