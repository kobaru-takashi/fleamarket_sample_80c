class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  def index
    @products = Product.all.order("created_at DESC").limit(5)
  end

  def new
    @category_parent_array = Category.where(ancestry: nil)
    @product = Product.new

  end

  def create
    Product.create(product_params)
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
  end

  def edit
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
  end
  
  def show
    @user = @product.user
  end

  private
  def product_params
    params.require(:params).permit(:name, :price, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
