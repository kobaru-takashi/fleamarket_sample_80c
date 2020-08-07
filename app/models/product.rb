class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images, inverse_of: :product
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
end

