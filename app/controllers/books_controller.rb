class BooksController < ApplicationController

  def index
    @books = Book.all
    @top_books = Book.top_books(3)
  end

  def show
    @book = Book.find(params[:id])
    @bottom_three_reviews = @book.bottom_three_reviews
    @top_three_reviews = @book.top_three_reviews
  end
end
