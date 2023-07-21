class UsersController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    # 他のユーザー情報をだすには
    @users = User.all
    @user = current_user
  end

  def show
    @books = Book.all
    @users = User.find(params[:id])
    @user = current_user
  end

  def edit
    @users = User.find(params[:id])
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)  
    
    
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
