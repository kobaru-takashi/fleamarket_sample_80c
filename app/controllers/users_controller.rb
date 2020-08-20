class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:show]
  before_action :set_parents, only: [:show, :likes]


  def destroy
    user.destroy
  end

  def show
    unless @user == current_user
      redirect_to root_path(@user)
    end
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