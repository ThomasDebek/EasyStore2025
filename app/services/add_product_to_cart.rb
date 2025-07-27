require 'dry/monads'

class AddProductToCart
  include Dry::Monads[:result, :do]

  def self.call(product_id, user)
    new.call(user: user, product_id: product_id)
  end

  def call(user:, product_id:)
    product = yield find_product(product_id)
    cart = user.cart || user.create_cart

    if cart.cart_items.find_by(admin_product_id: product.id)
      Failure("#{product.name} is already in your cart")
    else
      cart_item = cart.cart_items.new(admin_product_id: product.id)
      if cart_item.save
        Success("Added #{product.name} to cart")
      else
        Failure("Could not add #{product.name} to cart")
      end
    end
  end

  private

  def find_product(product_id)
    product = Admin::Product.find_by(id: product_id)
    product.present? ? Success(product) : Failure("Product not found")
  end
end