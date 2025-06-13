class Admin::BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_admin_brand, only: %i[ show edit update destroy ]

  # GET /admin/brands or /admin/brands.json
  def index
    @brands = Brand.all
  end

  # GET /admin/brands/1 or /admin/brands/1.json
  def show
  end

  # GET /admin/brands/new
  def new
    @brand = Brand.new
  end

  # GET /admin/brands/1/edit
  def edit
  end

  # POST /admin/brands or /admin/brands.json
  def create
    @brand = Brand.new(admin_brand_params)

    respond_to do |format|
      if brand.save
        format.html { redirect_to @brand, notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/brands/1 or /admin/brands/1.json
  def update
    respond_to do |format|
      if @brand.update(admin_brand_params)
        format.html { redirect_to @brand, notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/brands/1 or /admin/brands/1.json
  def destroy
    @brand.destroy!

    respond_to do |format|
      format.html { redirect_to admin_brands_path, status: :see_other, notice: "Brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def require_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_brand
      @brand = Brand.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def admin_brand_params
      params.expect(admin_brand: [ :name ])
    end
end
