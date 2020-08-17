$(document).on('turbolinks:load', ()=> {
  const buildFileField = (num)=> {
    const html = `
                <div class="label-content-${num}", id="label">
                  <label data-index="${num}" class="js-file_group" for="product_images_attributes_${num}_src">
                    <i class="fas fa-camera label-box-icon"></i>
                    <pre class="label-box__text-visible">クリックしてアップロード</pre>
                    <input class="js-file" type="file", name="product[images_attributes][${num}][src]", id="product_images_attributes_${num}_src">
                  </label>
                </div>
                  `;
    return html;
  }

  const buildImg = (index, url)=> {
    const html = `
                <div class="preview-box" id="preview-box__${index}">
                  <div class= "upper-box">
                    <img data-index="${index}" src="${url}" class="preview-image", alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="delete-box" id="delete_btn_${index}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>
                    `;
    return html;
  }

  const buildSmallFileField = (id) => {
    const html = `
                 <div class="label-content-small-${id}", id="label">
                  <label data-index="${id}" class="js-file_group" for="product_images_attributes_${id}_src">
                    <i class="fas fa-camera label-box-icon"></i>
                    <pre class="label-box__text-visible">クリックしてアップロード</pre>
                    <input class="js-file" type="file", name="product[images_attributes][${id}][src]", id="product_images_attributes_${id}_src">
                  </label>
                </div>
                 `;
    return html;
  }


  let fileIndex = [1,2,3,4,5];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      if ($('.preview-box').length < 5) {
        $('#previews').append(buildImg(targetIndex, blobUrl));
        $('#label').css("display","none");
        $(`.label-content-${targetIndex}`).css("display","none");
        $(`.label-content-small-${targetIndex}`).css("display","none");
        $('.label-content-edit__add').css("display", "none")
      }
      if ($('#labels div').length < 5) {
        $('#labels').append(buildFileField(fileIndex[0]));
        fileIndex.shift();
        fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      }
    }
  });

  $(document).on('click', '.delete-box', function() {
    var id = $(this).attr('id').replace(/[^0-9]/g, '');

    if ($('#labels div').length == $('.preview-box').length){
      $(`#preview-box__${id}`).remove();
      $(`#product_images_attributes_${id}_src`).val("");
      $(`.label-content-${id}`).remove();
      $(`.label-content-small-${id}`).remove();
      $('#labels').append(buildSmallFileField(id));
    } else {
      $(`#preview-box__${id}`).remove();
      $(`#product_images_attributes_${id}_src`).val("");
      $(`.label-content-${id}`).remove();
      $(`.label-content-small-${id}`).remove();
    }
  });

  $(document).on('click','.delete-box-edit', function(){
    const targetIndex = $(this).attr('id').replace(/[^0-9]/g, '');
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);

    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(`img[data-index="${targetIndex}"]`).remove();
    $(`#preview-box__${targetIndex}`).remove();
    $(`.label-content-${targetIndex}`).appendTo('#deleted');
    if ($('#labels div').length == $('.preview-box').length){
      $('#labels').append(buildSmallFileField(targetIndex + 1));
    }


    if ($('#labels div').length == 0) $('#labels').append(buildFileField(fileIndex[0]));
  });
});

$(function(){
  $('.pickupCategory-list__list').mouseover(function(){
    $(this).css("filter", "opacity(60%)");
  }).mouseout(function(){
    $(this).css("filter", "none");
  });
});

$(function(){
  $('.pickupBrand-list').mouseover(function(){
    $(this).css("filter", "opacity(60%)");
  }).mouseout(function(){
    $(this).css("filter", "none");
  });
});