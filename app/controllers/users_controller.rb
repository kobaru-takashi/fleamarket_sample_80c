class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:show]

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

  def show
    unless @user == current_user
      redirect_to root_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
