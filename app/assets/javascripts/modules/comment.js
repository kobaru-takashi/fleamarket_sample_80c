function PLEdelete(index){
  var html = 
  `
  <div class="comment__info"></div>
  このコメントは削除されました。
  <div class="comment__restore" data-index=${index}>
    <a href="/comments/${index}/restore">復元</a>
  </div>
  <div class="comment__complete-delete" data-index="${index}">
    <a rel="nofollow" data-method="delete" href="/comments/${index}">完全に削除</a>
  </div>
  `
return html;
};

$(".comment-form__input").on('click',".comment__pre-delete",function(e){
  e.preventDefault()
  var index = $(this).data("index");
  var content =  $(`.comment__box[data-index=${index}]`).find(".comment__content");
  content.empty();
  content.append(PLEdelete(index));
});

$(".comment-form__input").on('click','.comment__complete-delete',function(e){
  e.preventDefault()
  var index = $(this).data("index");
  $(`.comment__box[data-index=${index}]`).remove();
});
