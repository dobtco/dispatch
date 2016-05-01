$(document).on 'click', '.js-toggle-filters', ->
  $(@).toggleClass('is_active')
  $('.info_box_filters').toggleClass('is_active')
