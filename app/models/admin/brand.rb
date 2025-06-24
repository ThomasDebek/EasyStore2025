class Admin::Brand < ApplicationRecord
  has_many :products, class_name: 'Admin::Product', dependent: :destroy
end
