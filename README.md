# DB設計

## Usersテーブル

|Column|Type|Option|
|------|----|------|
|nickname|string|null: false, index: true, unique: true|
|email|string|null: false, index: true, unique: true|
|birth|date|null: false|

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
|delivery-fee|integer|null: false|
|send-from|string|null: false|
|delivery-date|integer|null: false|
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
|credit-number|integer|null: false|
|date-month|integer|null: false|
|date-year|integer|null: false|
|security-code|integer|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :user


## Addressesテーブル
|Column|Type|Option|
|------|----|------|
|family-name|string|null: false|
|first-name|string|null: false|
|family-name-kana|string|null: false|
|first-name-kana|string|null: false|
|post-code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|------|
|telephone-number|integer|-----|

### Association
- belongs_to :user


## Identificationsテーブル
|Column|Type|Option|
|------|----|------|
|family-name|string|null: false|
|first-name|string|null: false|
|family-name-kana|string|null: false|
|first-name-kana|string|null: false|
|birth|date|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :user


## Categoriesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

### Association
- has_many :products
- has_ancestry


![er-fleamarket80](https://user-images.githubusercontent.com/67687475/89366305-9c9a5f80-d711-11ea-98b0-c4dc0a96d6b4.jpg)