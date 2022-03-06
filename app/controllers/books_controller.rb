class BooksController < ApplicationController
 before_action :authenticate_user!
  def show
    @book = Book.find(params[:id])
    @user=User.find(params[:id])
    @book_comment=BookComment.new
  end

  def index
    @books = Book.all
    @book=Book.new
    @user=current_user

  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @user=current_user
    #@book.user.id=current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      flash.now[:alert]='error'
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  def destroy
    book=Book.find(params[:id])
    if book.destroy
      redirect_to books_path
    else
      render "Show"
    end
  end

  private

  def book_params
    # mergeを書いていないエラー
    # アソシエーションの関係上、user_idもストロングパラメータに設定しないといけない
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end
end