class BooksController < ApplicationController

  def index
    @books = Book.all
    @top_books = Book.top_books(3)
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    Book.destroy(book_params[:id])
    redirect_to books_path
  end

  private

    def book_params
      params.permit(:id)
    end
end
