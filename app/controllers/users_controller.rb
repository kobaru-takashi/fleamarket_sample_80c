class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:show]


  def destroy
    user.destroy
  end

  def show
    unless @user == current_user
      redirect_to root_path(@user)
    end
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
end