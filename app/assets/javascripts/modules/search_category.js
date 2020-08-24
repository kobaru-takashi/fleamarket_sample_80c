$(document).on('turbolinks:load', function(){

  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendCheckbox(category){
      let html =`
                  <div class="search-category-check-box-form">
                    <div class="search-category-check-box-form__btn js_search_checkbox">
                      <input type="checkbox" value="${category.id}" name="q[category_id_in][]" id="q_category_id_in_${category.id}" >
                    </div>
                    <div class="search-category-check-box-form__label">
                      <label for="q_category_id_in_${category.id}">${category.name}</label>
                    </div>
                  </div>
                  `
      return html;
    }

    function appendChildrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `
                       <div class='listing-select-wrapper__added' id= 'children_wrapper'>
                          <div class='listing-select-wrapper__box'>
                            <select class="listing-select-wrapper__box--select" id="child_category_search" name="q[category_id_start_all]">
                              <option value="" data-category="">選択してください</option>
                              ${insertHTML}
                            <select>
                          </div>
                        </div>
      `;
      $('.listing-product-detail__category').append(childSelectHtml);
    }
    function appendGrandchildrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `
                            <div class='search-category-check-box' id= 'grandchildren_wrapper'>
                              ${insertHTML}
                            </div>
                            `;
      $('.listing-product-detail__category').append(grandchildSelectHtml);
    }
    $('#parent_category_search').on('change', function(){
      var parentCategory = document.getElementById('parent_category_search').value;
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
    $('.listing-product-detail__category').on('change', '#child_category_search', function(){
      var childId = $('#child_category_search option:selected').data('category');
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
            insertHTML += appendCheckbox(grandchild);
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


$(function(){
  $('.search-drop__btn-green').click(function() {
    if ($('#child_category_search').val() == "") {
      $('#child_category_search').remove();
    }
  });
});