$(document).on 'ajax:beforeSend', '.js-remove-attachment', ->
  $(@).closest('li').remove()

$ ->
  return unless $('#attachment_upload')[0]

  $error = $('#attachment_upload').closest('.form_item').find('.js-upload-error')
  $label = $('label[for=attachment_upload]')
  originalText = $label.text()

  $('#attachment_upload').inlineFileUpload
    start: ->
      $label.addClass('disabled')

    progress: (data) ->
      $label.text(
        if data.percent == 100
          'Finishing...'
        else
          "Uploading (#{data.percent}%)"
      )

    complete: ->
      $label.html(originalText).removeClass('disabled')

    success: (data) ->
      $(data.data.html).appendTo('.js-attachments-list')

    error: (data) ->
      $error.text(data.xhr.responseJSON?.error || 'Error').show()
      setTimeout ->
        $error.hide()
      , 3000
