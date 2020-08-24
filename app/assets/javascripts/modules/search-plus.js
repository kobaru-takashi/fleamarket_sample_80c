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


$(function () {
  $(".search-drop__btn-reset").on("click", function () {
      clearForm(this.form);
  });

  function clearForm (form) {
    $(form)
        .find("input, select, textarea")
        .not(":button, :submit, :reset, :hidden")
        .val("")
        .prop("checked", false)
        .prop("selected", false)
    ;
    $('select[name=sort_order]').children().first().attr('selected', true);
    $('#child_category_search').remove();
    $('#grandchildren_wrapper').remove();
  }
});
