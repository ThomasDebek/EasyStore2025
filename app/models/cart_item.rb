class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :admin_product
end
