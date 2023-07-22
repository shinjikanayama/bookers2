class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end



  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       @user = current_user
       render :index

    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
      # 調べて入力「再表示する」
       flash.now[:alert]
       render :edit
    end

  end




  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def is_matching_login_user
     user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
