$ ->
  $('input.datetime_picker').each ->
    $input = $(@)
    $hiddenInput = $("<input type='hidden' name=\"#{$input.attr('name')}\" />")
    $hiddenInput.insertAfter($input)
    $input.attr('name', null)
    rome(@, initialValue: new Date($input.val())).on 'data', ->
      $hiddenInput.val(new Date($input.val()))
