$ ->
  $('input.datetime_picker').each ->
    $input = $(@)
    $hiddenInput = $("<input type='hidden' name=\"#{$input.attr('name')}\" />")
    $hiddenInput.insertAfter($input)
    $input.attr('name', null)
    rome(@, inputFormat: 'M/D/YYYY h:mma', min: Date(), timeFormat: "h:mma", timeInterval: 3600,
      initialValue: new Date($input.val())).on 'data', ->
      $hiddenInput.val(new Date($input.val()))
