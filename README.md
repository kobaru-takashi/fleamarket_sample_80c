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
- has_many :comments
- has_one :credit
- has_one :address


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

### Association
- belongs_to :user
- belongs_to :saler, class_name: "User"
- belongs_to :buyer, class_name: "User", optional: true
- belongs_to :category
- has_many :images, inverse_of: :product
- has_many :comments, inverse_of: :product
- accepts_nested_attributes_for :images


## Imageテーブル
|Column|Type|Option|
|------|----|------|
|product_id|integer|null: false|
|src|string|null: false|

### Association
- belongs_to :product, inverse_of: :images


## Creditsテーブル
|Column|Type|Option|
|------|----|------|
|user＿id|integer|null: false|
|customer_token|-----|-----|
|credit_token|-----|-----|


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


![er-fleamarket再訂正](https://user-images.githubusercontent.com/67687475/89699136-ec6e6600-d95f-11ea-8636-dfcc00853450.jpg)