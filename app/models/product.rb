class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :brand
  belongs_to :category



  scope :by_brand, ->(brand_id) {
    brand_id.present? ? where(brand_id: brand_id) : all
  }

  scope :by_category, ->(category_id) {
    category_id.present? ? where(category_id: category_id) : all
  }
end
