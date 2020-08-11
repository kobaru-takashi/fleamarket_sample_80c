class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show ]

  def index
    @products = Product.all.order("created_at DESC").limit(5)
  end

  def new
    @product = Product.new
    @image = @product.images.build
    @category_parent_array = ["選択してください"]
      Category.where(ancestry: nil).each do |parent|
          @category_parent_array << parent.name
      end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
 end

 def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
 end

  def create
    @product = Product.create(product_params)
    @category_parent_array = Category.where(ancestry: nil)
    if @product.save
      params[:images]['image'].each do |i|
        @image = @product.images.create(:image => i, :product_id => @product.id)
      end
      redirect_to root_path
    else
      render :new
    end
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
    params.require(:product).permit(:name, :price, :images,:price, :content, :condition, :delivery_fee, :send_from, :delivery_date,:category, :category_id, :brand, images_attributes: [:id, :image, :product_id]).merge(user_id: current_user.id)
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
