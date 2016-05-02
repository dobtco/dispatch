$ ->
  return unless $('body').data('page-key') == 'opportunities-edit'
  $('form.edit_opportunity').progressGuard()
