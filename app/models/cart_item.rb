class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :admin_product, class_name: "Admin::Product", foreign_key: "admin_product_id"
end
