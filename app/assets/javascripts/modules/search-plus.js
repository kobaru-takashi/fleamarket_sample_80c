$(document).on('turbolinks:load', function(){
  $('.search-sort__right').on("click", function(){
    $(".search-drop-box").toggleClass("is-show").toggleClass("not-show")
  });
});
