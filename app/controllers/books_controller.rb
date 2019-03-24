class BooksController < ApplicationController

  def index
    @books = Book.all
    @top_books = Book.top_books(3)
    @bottom_books = Book.bottom_books(3)
    @top_reviewers = Review.top_reviewers(3)
  end

  def show
    @book = Book.find(params[:id])
  end
end
