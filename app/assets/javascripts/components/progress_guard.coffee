class ProgressGuard
  constructor: ($el, options) ->
    @hasChanges = false
    @$el = $el

    @$el.on 'input', ':input', @changed
    @$el.on 'change', 'select', @changed
    @$el.on 'click', 'input[type=radio], input[type=checkbox]', @changed
    @$el.on 'submit', @clear

    window.onbeforeunload = =>
      if @hasChanges then "You have unsaved changes" else undefined

  changed: =>
    @hasChanges = true

  clear: =>
    @hasChanges = false
    return # Don't return false!

$.fn.extend progressGuard: (option, args...) ->
  @each ->
    data = $(@).data('progress-guard')

    if !data
      $(@).data 'progress-guard', (data = new ProgressGuard($(@), option))
    if typeof option == 'string'
      data[option].apply(data, args)
