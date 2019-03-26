class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    author_names = params[:authors].split(',')
    author_names = author_names.map do |author|
      author.titleize
    end
    book = Book.new(book_params)
    if book.book_cover_url == ''
      book.book_cover_url = 'https://islandpress.org/sites/default/files/400px%20x%20600px-r01BookNotPictured.jpg'
    end
    if book.save
      assign_book_to_author(author_names, book)
      redirect_to book_path(book[:id])
    else
      redirect_to books_path
    end
  end

  def assign_book_to_author(author_names, book)
    author_names.each do |name|
      author = Author.find_or_create_by(name: name.strip)
      author.books << book
    end
  end

  def index
    @top_books = Book.top_books(3)
    @bottom_books = Book.bottom_books(3)
    @top_reviewers = Review.top_reviewers(3)
    if params[:sort]
      @books = Book.sort_by(params[:sort])
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @bottom_three_reviews = @book.bottom_three_reviews
    @top_three_reviews = @book.top_three_reviews
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :number_of_pages, :year_published, :book_cover_url)
  end
end
