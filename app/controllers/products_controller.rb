class ProductsController < ApplicationController
  before_action :load_brands_and_categories
  def index
    if user_signed_in? && current_user.admin?
      redirect_to admin_products_path
    else
      @products = Admin::Product.all
      @products = @products.where(brand_id: params[:brand_id]) if params[:brand_id].present?
      @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    end
  end

  def show
    @product = Admin::Product.find(params[:id])
  end

  private
  def load_brands_and_categories
    @brands = Admin::Brand.all
    @categories = Admin::Category.all
  end

end