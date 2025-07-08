require 'dry/monads'

class AddProductToCart
  include Dry::Monads[:result, :do]

  def call(user:, product_id:)
    product = yield find_product(product_id)
    cart = user.cart || user.create_cart

    if cart.cart_items.find_by(admin_product_id: product.id)
      Failure("#{product.name} is already in your cart")
    else
      cart.cart_items.create(admin_product_id: product.id)
      Success("Added #{product.name} to cart")
    end
  end

  private

  def find_product(product_id)
    product = Admin::Product.find(product_id)
    product.present? ? Success(product) : Failure("Product not found")
  end
end