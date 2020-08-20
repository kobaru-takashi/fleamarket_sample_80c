class CategoriesController < ApplicationController
  before_action :set_parents, only: [:index, :show]
  before_action :set_parent_array, only: [:show]

  def index
    @parents = Category.where(ancestry: nil)
  end

  def new
    
  end

  def create

  end

  def show
    @parents = Category.where(ancestry: nil)
    @category = Category.find(params[:id])
    @products = @category.set_products
    # @products = @products.where(buyer_id: nil).order("created_at DESC")
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def set_parent_array
    @category_parent_array = Category.where(ancestry: nil)
  end

end

