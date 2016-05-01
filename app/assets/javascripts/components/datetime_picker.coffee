format = 'M/D/YYYY h:mma'

$ ->
  $('input.datetime_picker').each ->
    $input = $(@)
    $hiddenInput = $("<input type='hidden' name=\"#{$input.attr('name')}\" />")
    $hiddenInput.insertAfter($input)
    $input.attr('name', null)
    rome(
      @,
      inputFormat: format,
      timeFormat: "h:mma",
      timeInterval: 3600 # hour
      initialValue: new Date($input.val())
    ).on 'data', ->
      $hiddenInput.val moment($input.val(), format).toDate()
