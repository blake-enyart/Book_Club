class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    author_names = params[:authors].split(',')
    book = Book.create(book_params)
    # if Book.already_exists?(book)
    #   redirect_to new_book_path
    # else
    book.save
    assign_book_to_author(author_names, book)
    redirect_to book_path(book[:id])
  end

  def assign_book_to_author(author_names, book)
    author_names.each do |name|
      author = Author.find_or_create_by(name: name.strip)
      author.books << book
    end
  end

  def index
    @books = Book.all
    @top_books = Book.top_books(3)
    @bottom_books = Book.bottom_books(3)
    @top_reviewers = Review.top_reviewers(3)
  end

  def show
    @book = Book.find(params[:id])
    @bottom_three_reviews = @book.bottom_three_reviews
    @top_three_reviews = @book.top_three_reviews
  end

  private

  def book_params
    params.require(:book).permit(:title, :year_published, :number_of_pages, :book_cover_url, :authors)
  end
end
