class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def destroy
    author = Author.find(params[:id])
    destroy_books_by_author(author)
    redirect_to books_path
  end

  def destroy_books_by_author(author)
    Book.all.each do |book|
      book.authors.each do |book_author|
        if book_author == author
          book.destroy
        end
      end
    end
  end
end
