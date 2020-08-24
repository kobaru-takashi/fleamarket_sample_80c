crumb :root do
  link "トップページ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user)
end

crumb :user do
  link "本人情報", edit_user_registration_path
  parent :mypage
end

crumb :user_address do
  link "送付先住所", addresses_path
  parent :user
end

crumb :new_product do
  link "商品を出品する", new_product_path
  parent :mypage
end

crumb :card do
  link "クレジットカード情報", card_index_path
  parent :mypage
end

crumb :categories do
  link "カテゴリー一覧", categories_path
end

crumb :parent_category do |category|
  category = Category.find(params[:id]).root
  link "#{category.name}", category_path(category)
  parent :categories
end

crumb :child_category do |category|
  category = Category.find(params[:id])
  if category.has_children?
    link "#{category.name}", category_path(category)
    parent :parent_category
  else
    link "#{category.parent.name}", category_path(category.parent)
    parent :parent_category
  end
end

crumb :grandchild_category do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(category)
  parent :child_category
end

crumb :show_product do |product,category|
  category = Category.find(params[:id])
  product = Product.find(params[:id])
  link "#{Product.name}"
