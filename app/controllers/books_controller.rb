class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end



  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    @book.save
    redirect_to book_path(@book.id)

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end




  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
