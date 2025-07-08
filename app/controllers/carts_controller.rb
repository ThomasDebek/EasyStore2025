class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart
    @cart_items = @cart.cart_items.includes(:admin_product)
  end

  def add
    result = AddProductToCart.call(params[:product_id], current_user)

    if result.success?
      redirect_to cart_path, notice: result.value!
    else
      redirect_to cart_path, alert: result.failure
    end
  end

  def remove_item
    cart = current_user.cart
    @cart_items = cart.cart_items.find_by(id: params[:item_id])
    item&.destroy
    redirect_to cart_path, notice: "Item removed from cart"
  end

  def destroy
    current_user.cart&.cart_items&.destroy_all
    redirect_to cart_path, notice: "Cart cleared"
  end
end