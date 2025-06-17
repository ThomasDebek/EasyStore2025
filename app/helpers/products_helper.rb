module ProductsHelper
  def brands
    @brands ||= Brand.all
  end

  def categories
    @categories ||= Category.all
  end
end
