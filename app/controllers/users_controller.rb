class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

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

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def set_user
    @user = User.find(current_user.id)
  end

end
