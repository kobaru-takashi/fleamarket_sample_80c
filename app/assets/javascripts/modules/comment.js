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

  $(".comment-form__input").on('click','.comment__complete-delete',function(e){
    e.preventDefault()
    var index = $(this).data("index");
    $(`.comment__box[data-index=${index}]`).remove();
  });
});
