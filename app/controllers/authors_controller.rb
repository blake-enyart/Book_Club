class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def destroy
    author = Author.find(params[:id])
    destroy_books_by_author(author)

    author.destroy
    redirect_to books_path
  end

  def destroy_books_by_author(author)
    author.books.each do |book|
      book.destroy
    end
  end
end
