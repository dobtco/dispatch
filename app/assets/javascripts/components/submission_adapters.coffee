disableInvisibleInputs = ->
  $('[data-adapter-name]').each ->
    if $(@).is(':visible')
      $(@).find(':input').prop('disabled', false)
    else
      $(@).find(':input').prop('disabled', true)

$ ->
  $('#opportunity_submission_adapter_name').on 'change', ->
    $('[data-adapter-name]').hide()
    $("[data-adapter-name=\"#{$(@).val()}\"]").show()
    disableInvisibleInputs()

  disableInvisibleInputs()
