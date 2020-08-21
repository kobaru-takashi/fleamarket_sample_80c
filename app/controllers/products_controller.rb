class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index,:show ]
  before_action :set_parents, only: [:index,  :new, :create, :edit, :show, :search, :search_detail]
  before_action :set_parent_array, only: [:new, :create, :edit, :update, :search, :search_detail, ]
  before_action :set_product_search_query

  def index
    @products = Product.includes(:images).order('created_at DESC').limit(5)
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      flash.now[:alert] = '削除できませんでした'
      render :show
    end
  end

  def edit
    @category_grandchild = @product.category
    @category_grandchildren_edit = Category.find_by(id: @category_grandchild.id ).children
    if @category_grandchild.parent.present?
      @category_child = @category_grandchild.parent
      @category_children_edit = Category.find_by(id:@category_child.id).children
      @category_grandchildren_edit = Category.find_by(id: @category_grandchild.id ).children
      if @category_child.parent.present?
        @category_parent = @category_child.parent
        @category_children_edit = Category.find_by(id: @category_parent.id).children
        @category_grandchildren_edit = Category.find_by(id: @category_child.id ).children
      end
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(params[:id])
    else
      render :edit
    end
  end

  def show
    @user = @product.user
    @product = Product.find(params[:id])
    @images = @product.images
    @images_first = @product.images.first
    @category_id = @product.category_id
    @category_grandchild = Category.find(@category_id)
    if @category_grandchild.parent.present?
      @category_child = Category.find(@category_id).parent
      if @category_child.parent.present?
        @category_parent = @category_child.parent
      end
    end
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

  def search
    if category_key = params.require(:q)[:category_id]
      if category_key.to_i == 0
        @search_category = Category.find_by(name: category_key, ancestry: nil)
      else
        @search_category = Category.find(category_key)
      end

      if @search_category.present?
        if @search_category.ancestry.nil?
          @category_child_array = Category.where(ancestry: @search_category.id).pluck(:name, :id)
          grandchildren_id = @search_category.indirect_ids.sort
          find_category_product(grandchildren_id)
        elsif @search_category.ancestry.exclude("/")
          @category_child = @search_category
          @category_child_array = @search_category.siblings.pluck(:name, :id)
          @category_grandchild_array = @search_category.children
          grandchildren_id = @search_category.chid_ids
          find_category_product(grandchildren_id)
        end
      end
    end


  end

  def search_detail

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

  def set_parent_array
    @category_parent_array = Category.where(ancestry: nil)
  end

end
