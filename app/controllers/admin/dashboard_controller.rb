class Admin::DashboardController < ApplicationController
  def show
  end

  def products_count
    @products_count = Product.count()
  end
  helper_method :products_count

  def catagories_count
    @catagories_count = Category.count()
  end
  helper_method :catagories_count
end
