class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images, inverse_of: :product
  accepts_nested_attributes_for :images
end
