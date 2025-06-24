class Admin::Category < ApplicationRecord
  has_many :admin_products, :class_name => 'Admin::Product', dependent: :destroy
end
