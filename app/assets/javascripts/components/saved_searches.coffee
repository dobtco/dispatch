$(document).on 'ajax:beforeSend', '.js-destroy-saved-search', ->
  $(@).closest('li').remove()
