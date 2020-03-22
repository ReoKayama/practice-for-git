$(document).on('turbolinks:load', function(){
  $('.fa-list').click(function() {
    $('.ladder-menu').fadeIn();
    $(this).css('display', 'none');
    $('.fa-times').css('display', 'block')
  });
  
  $('.fa-times').click(function(){
    $('.ladder-menu').fadeOut();
    $(this).css('display', 'none');
    $('.fa-list').css('display', 'block')
  });
  
  $('.open').click(function() {
    $(this).hide();
    $(this).nextAll('.favo-items').slideDown();
    $(this).next('.close').show();
  })
  
  $('.close').click(function() {
    $(this).hide();
    $(this).nextAll('.favo-items').slideUp();
    $(this).prev('.open').show();
  })
  
  
})