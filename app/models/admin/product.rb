class Admin::Product < ApplicationRecord
  has_one_attached :image
  belongs_to :brand, class_name: 'Admin::Brand'
  belongs_to :category, class_name: 'Admin::Category'
end
