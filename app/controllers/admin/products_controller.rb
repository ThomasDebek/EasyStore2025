class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_admin_product, only: %i[ show edit update destroy ]
  before_action :load_brands_and_categories, only: [:index, :new, :edit, :create, :update]


  # GET /admin/products or /admin/products.json
  def index
    @admin_products = Admin::Product.all
    @admin_products = Admin::Product.search_by_name(params[:query]) if params[:query].present?
    @admin_products = @admin_products.where(brand_id: params[:brand_id]) if params[:brand_id].present?
    @admin_products = @admin_products.where(category_id: params[:category_id]) if params[:category_id].present?
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
  end

  # GET /admin/products/new
  def new
    @admin_product = Admin::Product.new
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products or /admin/products.json
  def create
    @admin_product = Admin::Product.new(admin_product_params)

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to @admin_product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @admin_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    respond_to do |format|
      if @admin_product.update(admin_product_params)
        format.html { redirect_to @admin_product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @admin_product.destroy!

    respond_to do |format|
      format.html { redirect_to admin_products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def load_brands_and_categories
    @brands = Admin::Brand.all
    @categories = Admin::Category.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_product
    @admin_product = Admin::Product.find(params.expect(:id))
  end

  def require_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end

  # Only allow a list of trusted parameters through.
  def admin_product_params
    params.expect(admin_product: [:name, :description, :price, :brand_id, :category_id, :image])
  end
end
