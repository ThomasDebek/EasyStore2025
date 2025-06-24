class Admin::BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_admin_brand, only: %i[show edit update destroy]

  def index
    @admin_brands = Admin::Brand.all
  end

  def show
  end

  def new
    @admin_brand = Admin::Brand.new
  end

  def edit
  end

  def create
    @admin_brand = Admin::Brand.new(admin_brand_params)
    if @admin_brand.save
      redirect_to admin_brand_path(@admin_brand), notice: "Brand was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admin_brand.update(admin_brand_params)
      redirect_to admin_brand_path(@admin_brand), notice: "Brand was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_brand.destroy!
    redirect_to admin_brands_path, status: :see_other, notice: "Brand was successfully destroyed."
  end

  private

  def require_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end

  def set_admin_brand
    @admin_brand = Admin::Brand.find(params[:id])
  end

  def admin_brand_params
    params.require(:admin_brand).permit(:name)
  end
end