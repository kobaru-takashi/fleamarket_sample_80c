class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:show]
  before_action :set_parents, only: [:show, :listed_product,:sold, :purchased_product, :likes]

  def destroy
    user.destroy
  end

  def show
    unless @user == current_user
      redirect_to root_path(@user)
    end
  end

  def listed_product
    @user = User.find(params[:user_id])
  end

  def sold
    @current_user_items = current_user.products
    @sold_current_user_items = @current_user_items.where.not(buyer_id: nil)
  end

  def purchased_product
    @items = Product.where(params[:id])
    @purchased_items = @items.where(buyer_id: current_user.id)
  end

  def likes
    @user = User.find(params[:user_id])
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :nickname)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

end