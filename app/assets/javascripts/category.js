$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = `<div class="category__child" id="children_wrapper">
                        <select id="child__category" name="product[category_id]" class="serect_field">
                          <option value="">---</option>
                          ${insertHTML}
                        </select>
                      </div>`;
    $('.append__category').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = "";
    grandchildSelectHtml = `<div class="category__child" id="grandchildren_wrapper">
                              <select id="grandchild__category" name="product[category_id]" class="serect_field">
                                <option value="">---</option>
                                ${insertHTML}
                                </select>
                            </div>`;
    $('.append__category').append(grandchildSelectHtml);
  }

  $('#product_category_id').on('change',function(){
    var parentId = document.getElementById('product_category_id').value;
    if (parentId != ""){
      $.ajax({
        url: '/product/get_category_children/',
        type: 'GET',
        data: { parent_id: parentId },
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
  $('.append__category').on('change','#child__category',function(){
    var childId = document.getElementById('child__category').value;
    if(childId != "" && childId != 46 && childId != 74 && childId != 134 && childId != 142 && childId != 147 && childId != 150 && childId != 158){
      $.ajax({
        url: '/product/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  })
});

$(function(){
  $('.category__parent--name').mouseover(function(){
    $(this).css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    $(this).css("background-color", "white").css("color", "black");
  });
  $('.category__child--name').mouseover(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css("background-color", "lightgray");
    parent.css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css("background-color", "white").css("color", "black");
    parent.css("background-color", "#3ccace").css("color", "white");
  });
  $('.category__grandchild--name').mouseover(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css("background-color", "lightgray")
    child.css("background-color", "lightgray");
    parent.css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css("background-color", "white").css("color","black");
    child.css("background-color", "white").css("color","black");
    parent.css("background-color", "white").css("color","black");
  });
})