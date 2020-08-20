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