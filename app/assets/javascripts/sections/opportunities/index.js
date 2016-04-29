$(function(){
  if(matchMedia('only screen and (max-width: 640px)').matches) {
    $('.info_box').addClass('is_hidden');
    $('#filter_mobile').on('click', function(){
      console.log('uhhh');
      $(this).toggleClass('is_active');
      $('.info_box').toggleClass('is_hidden');
    });
  }
});
