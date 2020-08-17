$(document).on('turbolinks:load', function(){
  $('.image-sub-list').on("mouseover", function(){
    let tabs = $(".image-sub-list");

    function tabSwitch(){
      $(".active").removeClass("active");
      $(this).addClass("active");
      const index = tabs.index(this);
      $(".image-main-tag").removeClass("show").eq(index).addClass("show");
    }
    tabs.mouseover(tabSwitch);
  });
});