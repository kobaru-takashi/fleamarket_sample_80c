$(document).on('turbolinks:load', function(){
  // コメント表示・復元
  function new_comment(comment_data){
    var html = 
      `
      <div class="comment__box" data-index=${comment_data.id}>
        <div class="comment__user-name">
        ${comment_data.user_nickname}
          <div class="saler_display">
          出品者
          </div>
        </div>
        <div class="comment__content">
          <div class="comment__create-at">
          ${comment_data.created_at}
          </div>
          <div class="comment__text">
          ${comment_data.comment}
          </div>
          <div class="comment__pre-delete" data-index=${comment_data.id}>
            <a rel="nofollow" data-method="patch" href="/comments/${comment_data.id}">仮削除</a>
          </div>
        </div>
      </div>
      `
    // var HTML_content = 
    //   `
    //   <div class="comment__box" data-index=${comment_data.id}>
    //     <div class="comment__user-name">
    //     ${comment_data.user_nickname}
    //       <div class="saler_display">
    //       出品者
    //       </div>
    //     </div>
    //     <div class="comment__content">
    //       <div class="comment__create-at">
    //       ${comment_data.created_at}
    //       </div>
    //       <div class="comment__text">
    //       ${comment_data.comment}
    //       </div>
    //   `
    // var HTML_preDeleteBtn = 
    //   `
    //       <div class="comment__pre-delete" data-index=${comment_data.id}>
    //         <a rel="nofollow" data-method="patch" href="/comments/${comment_data.id}">仮削除</a>
    //       </div>
    //   `
    // var HTML_endDiv =
    //   `
    //     </div>
    //   </div>
        //  `
    // if  (comment_data.user_id == currentUser.id){
    // 　var html = HTML_content + HTML_preDeleteBtn + HTML_endDiv
    // }else{
    //   var html = HTML_content + HTML_endDiv
    // }
    return html;
  };

  // コメント作成した場合
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

  // 仮削除表示用
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

  // 復元した場合
  $(".comment-form__input").on('click',".comment__pre-delete",function(e){
    e.preventDefault()
    var index = $(this).data("index");
    var content =  $(`.comment__box[data-index=${index}]`).find(".comment__content");
    content.empty();
    content.append(PLEdelete(index));
  });

  // 完全削除した場合
  $(".comment-form__input").on('click','.comment__complete-delete',function(e){
    e.preventDefault()
    var index = $(this).data("index");
    $(`.comment__box[data-index=${index}]`).remove();
  });

})
