$(document).on('turbolinks:load', function(){
  $('.search-sort__right').on("click", function(){
    $(".search-drop-box").toggleClass("is-show").toggleClass("not-show")
    $(".search-sort-drop").removeClass("is-show").addClass("not-show")
  });
});


$(document).on('turbolinks:load', function(){
  $('.search-sort__left').on("click", function(){
    $(".search-sort-drop").toggleClass("is-show").toggleClass("not-show")
    $(".search-drop-box").removeClass("is-show").addClass("not-show")
  });
});