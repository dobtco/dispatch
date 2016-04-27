$ ->
  $('[data-show-if-selected]').each ->
    $el = $(@)
    [selector, valueToMatch] = $(@).data('show-if-selected').split('|')
    $input = $(selector)
    showHide = -> $el[if $input.val() in valueToMatch.split(',') then 'show' else 'hide']()
    $input.on 'change.show_if_selected', $input, showHide
