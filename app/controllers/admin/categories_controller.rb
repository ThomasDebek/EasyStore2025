class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_admin_category, only: %i[show edit update destroy]

  def index
    @admin_categories = Category.all
  end

  def show
  end

  def new
    @admin_category = Category.new
  end

  def edit
  end

  def create
    @admin_category = Category.new(admin_category_params)
    if @admin_category.save
      redirect_to [:admin, @admin_category], notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admin_category.update(admin_category_params)
      redirect_to [:admin, @admin_category], notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_category.destroy!
    redirect_to admin_categories_path, status: :see_other, notice: "Category was successfully destroyed."
  end

  private

  def require_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end

  def set_admin_category
    @admin_category = Category.find(params[:id])
  end

  def admin_category_params
    params.require(:category).permit(:name)
  end
end