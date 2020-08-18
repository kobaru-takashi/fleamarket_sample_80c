class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      redirect_to root_path
    else
      flash.now[:alert] = 'ログアウトできませんでした'
      render :show
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


end
