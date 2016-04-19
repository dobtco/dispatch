$(document).on 'click', '[data-toggle-visible]', ->
  $($(@).data('toggle-visible')).toggle()
