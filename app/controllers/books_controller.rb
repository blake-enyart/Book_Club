class BooksController < ApplicationController

  def index
    @books = Book.all
    @top_books = Book.top_books(3)
  end

  def show
    @book = Book.find(params[:id])
  end
end
