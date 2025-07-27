class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :disable_turbo_redirects, if: -> { devise_controller? }

  before_action :set_filters_data

  private

  def set_filters_data
    @brands = Admin::Brand.all
    @categories = Admin::Category.all
  end

  def disable_turbo_redirects
    if request.headers["Turbo-Frame"]
      response.set_header("Turbo-Location", request.original_url)
    end
  end

end


