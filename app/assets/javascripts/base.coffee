# Allow us to use href='#' without jumping to the top of the page.
# Otherwise, we'd have to use javascript:void(0) which sucks.
$(document).on 'click', '[href="#"]', (e) ->
  e.preventDefault()
