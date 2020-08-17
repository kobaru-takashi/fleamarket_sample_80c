$(document).on('turbolinks:load', function(){
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

$(document).on('turbolinks:load', function(){
  $('.category__parent--name').mouseover(function(){
    $(this).css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    $(this).css("background-color", "white").css("color", "black");
  });
  $('.category__child--name').mouseover(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css("background-color", "lightgray");
    parent.css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css("background-color", "white").css("color", "black");
    parent.css("background-color", "#3ccace").css("color", "white");
  });
  $('.category__grandchild--name').mouseover(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css("background-color", "lightgray")
    child.css("background-color", "lightgray");
    parent.css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css("background-color", "white").css("color","black");
    child.css("background-color", "white").css("color","black");
    parent.css("background-color", "white").css("color","black");
  });
})