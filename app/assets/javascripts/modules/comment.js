$(document).on('turbolinks:load', function(){
  function new_comment(comment_data){
    var html =
      `
      <div class="comment__box" id="comment-mine" data-index=${comment_data.id}>
        <div class="comment__user-name">
        ${comment_data.user_nickname}
          <span>さん</span>
        </div>
        <div class="comment__content" data-index=${comment_data.id}>
          <div class="comment__create-at">
          ${comment_data.created_at}
          </div>
          <div class="comment__text">
          ${comment_data.comment}
          </div>
          <div class="comment__complete-delete" data-index=${comment_data.id}>
          <a rel="nofollow" data-method="delete" href="/comments/${comment_data.id}">削除</a>
          </div>
        </div>
      </div>
      `
    return html;
  };

  $('.new_comment').on('submit', function(e){
    e.preventDefault()
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment_data){
      var html = new_comment(comment_data);
      $(".comment-form__input").append(html)
      $('.comment-form__body').val("");
      $('.comment-form__input').animate({ scrollTop: $('.comment-form__input')[0].scrollHeight});
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  });

  // $(".comment_list").on('click',".comment_restore",function(e){
  //   e.preventDefault()
  //   var index = $(this).data("index")
  //   var url =`/comments/${index}/restore`
  //   $.ajax({
  //     url: url,
  //     type: 'GET',
  //     dataType: 'json',
  //   })
  //   .done(function(comment_data){
  //     var html = new_comment(comment_data);
  //     $(`.comment__box[data-index=${index}]`).replaceWith(html)
  //   })
  //   .fail(function() {
  //     alert("メッセージ送信に失敗しました");
  //   });
  // });

  // function PLEdelete(index){
  //   var html =
  //   `
  //   <div class="comment__info">
  //   このコメントは削除されました。
  //   </div>
  //   <div class="comment__restore" data-index=${index}>
  //     <a href="/comments/${index}/restore" remote: true>復元</a>
  //   </div>
  //   <div class="comment__complete-delete" data-index="${index}">
      // <a rel="nofollow" data-method="delete" href="/comments/${index}">完全に削除</a>
  //   </div>
  //   `
  //   return html;
  // };

  // $(".comment-form__input").on('click',".comment__pre-delete",function(e){
  //   e.preventDefault()
  //   var index = $(this).data("index");
  //   var content =  $(`.comment__box[data-index=${index}]`).find(".comment__content");
  //   content.empty();
  //   content.append(PLEdelete(index));
  // });

  $(".comment-form__input").on('click','.comment__complete-delete',function(e){
    e.preventDefault()
    var index = $(this).data("index");
    $(`.comment__box[data-index=${index}]`).remove();
  });
});
