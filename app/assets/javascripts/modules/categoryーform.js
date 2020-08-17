$(document).on('turbolinks:load', function(){

  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendChildrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
      <div class='listing-select-wrapper__box'>
      <select class="listing-select-wrapper__box--select" id="child_category" name="product[category_id]">
      <option value="" data-category="">選択してください</option>
      ${insertHTML}
      <select>
      </div>
      </div>`;
      $('.listing-product-detail__category').append(childSelectHtml);
    }
    function appendGrandchildrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
      <div class='listing-select-wrapper__box'>
      <select class="listing-select-wrapper__box--select" id="grandchild_category" name="product[category_id]">
      <option value="" data-category="">選択してください</option>
      ${insertHTML}
      <select>
      </div>
      </div>`;
      $('.listing-product-detail__category').append(grandchildSelectHtml);
    }
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById('parent_category').value;
      if (parentCategory != ""){
        $.ajax({
          url: '/products/get_category_children_form',
          type: 'GET',
          data: { parent_id: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
      }
    });
    $('.listing-product-detail__category').on('change', '#child_category', function(){
      var childId = $('#child_category option:selected').data('category');
      if (childId != ""){
        $.ajax({
          url: '/products/get_category_grandchildren',
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });
});
});