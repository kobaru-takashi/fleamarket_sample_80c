# DB設計

## Usersテーブル

|Column|Type|Option|
|------|----|------|
|nickname|string|null: false, index: true, unique: true|
|email|string|null: false, index: true, unique: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_date|date|null: false|

### Association
- has_many :products
- has_one :card
- has_many :comments
- has_one :address
- has_many :likes


## Productsテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|price|integer|null: false|
|content|text|null: false|
|condition|integer|null: false|
|delivery_fee|integer|null: false|
|send_from|integer|null: false|
|delivery_date|integer|null: false|
|user_id|integer|null: false|
|category_id|integer|null: false|
|saler_id|integer|null: false|
|buyer_id|integer|------|
|likes_count|integer|------|

### Association
- belongs_to :user
- belongs_to :saler, class_name: "User"
- belongs_to :buyer, class_name: "User", optional: true
- belongs_to :category
- has_many :images, inverse_of: :product
- has_many :comments, inverse_of: :product
- accepts_nested_attributes_for :images
- has_many :likes


## Imageテーブル
|Column|Type|Option|
|------|----|------|
|product_id|integer|null: false|
|src|string|null: false|

### Association
- belongs_to :product, inverse_of: :images


## Cardsテーブル
|Column|Type|Option|
|------|----|------|
|user＿id|integer|null: false, foreign_key: true|
|customer_id|integer|null:false|
|card_id|integer|null:false|

### Association
- belongs_to :user


## Addressesテーブル
|Column|Type|Option|
|------|----|------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|------|
|telephone-number|integer|-----|

### Association
- belongs_to :user


## Categoriesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|ancestry|string|------|

### Association
- has_many :products
- has_ancestry

## Commentsテーブル
|Column|Type|Option|
|------|----|------|
|comment|string|------|
|delete_check|integer|default: 0|
|user_id|integer|null: false|
|product_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :product


## Likesテーブル
|Column|Type|Option|
|------|----|------|
|product_id|integer|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :product
- belongs_to :user


## Commentsテーブル
|Column|Type|Option|
|------|----|------|
|comment|string|------|
|delete_check|integer|default: 0|
|user_id|integer|null: false|
|product_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :product


## Likesテーブル
|Column|Type|Option|
|------|----|------|
|product_id|integer|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :product
- belongs_to :user



![er図-最終版](https://user-images.githubusercontent.com/67687475/90977694-3b341680-e582-11ea-9e39-e3f0c923638a.jpg)