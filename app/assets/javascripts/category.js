$(function(){
  $(function(){

    $('.box__parent--link').mouseover(function(){
      $(this).css("background-color", "#3ccace").css("color", "white");
    }).mouseout(function(){
      $(this).css("background-color", "white").css("color", "black");
    });
  $('a[href^="#"]').click(function() {
    var speed = 400; 
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top;
    $('body,html').animate({scrollTop:position}, speed, 'swing');
    return false;
    })
  });
});
