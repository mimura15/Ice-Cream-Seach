class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def update

  end

  def unsubscribe

  end

  def withdraw

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :message, :image)
  end
end
