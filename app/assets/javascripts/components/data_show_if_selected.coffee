$ ->
  $('[data-show-if-selected]').each ->
    $el = $(@)
    [selector, valueToMatch] = $(@).data('show-if-selected').split('|')
    $input = $(selector)
    $input.on 'change.show_if_selected', ->
      console.log $input.val()
      $el[if $input.val() in valueToMatch.split(',') then 'show' else 'hide']()
