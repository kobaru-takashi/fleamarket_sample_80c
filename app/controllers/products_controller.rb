class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index,:show ]
  before_action :set_parents, only: [:index,  :new, :create, :edit, :show]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
    @category_parent_array = Category.where(ancestry: nil)
  end


  def create
    @product = Product.new(product_params)
    @category_parent_array = Category.where(ancestry: nil)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = @product.user
    @category_id = @product.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
    @images = Image.where(product_id: params[:id])
    @images_first = Image.where(product_id: params[:id]).first
  end

  def get_category_children_form
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_children
    @category_children = Category.find(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end


  private
  def product_params
    params.require(:product).permit(:name, :price,:price, :content, :condition, :delivery_fee, :send_from, :delivery_date,:category_id, :brand, images_attributes: [:src, :_destroy, :id]).merge(saler_id: current_user.id).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

end
