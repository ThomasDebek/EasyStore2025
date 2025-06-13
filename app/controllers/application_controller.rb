class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern



  before_action :set_filters_data

  private

  def set_filters_data
    @brands = Brand.all
    @categories = Category.all
  end
end
