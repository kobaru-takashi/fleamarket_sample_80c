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
- has_many :credits
- has_one :address


## Productsテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|price|integer|null: false|
|content|text|null: false|
|condition|integer|null: false|
|delivery_fee|integer|null: false|
|send_from|string|null: false|
|delivery_date|integer|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :category
- has_many :images, inverse_of: :product
- accepts_nested_attributes_for :images


## Imageテーブル
|Column|Type|Option|
|------|----|------|
|product_id|integer|null: false|
|image|string|null: false|

### Association
- belongs_to :product, inverse_of: :images


## Creditsテーブル
|Column|Type|Option|
|------|----|------|
|credit_number|integer|null: false|
|date_month|integer|null: false|
|date_year|integer|null: false|
|security_code|integer|null: false|
|user_id|integer|null: false|

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
|telephone_number|string|-----|

### Association
- belongs_to :user


## Categoriesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

### Association
- has_many :products
- has_ancestry


![er-fleamarket再訂正](https://user-images.githubusercontent.com/67687475/89699136-ec6e6600-d95f-11ea-8636-dfcc00853450.jpg)