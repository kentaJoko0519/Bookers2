class BooksController < ApplicationController

  def create
    @newbook=Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice1] = "You have created book successfully."
      redirect_to book_path(@newbook.id)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end

  def index
    @newbook=Book.new
    @books=Book.all
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
    @newbook=Book.new
  end

  def edit
    @book=Book.find(params[:id])
    if current_user!=@book.user
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice1] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

    private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end