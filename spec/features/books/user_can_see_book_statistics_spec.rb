require "rails_helper"

RSpec.describe "user sees all books", type: :feature do
  describe 'user visits /books' do
    before(:each) do
      @book_1 = Book.create(title: "Title_1", number_of_pages: 100, year_published: 2001, book_cover_url: "book_cover_url_1")

      @book_2 = Book.create(title: "Title_2", number_of_pages: 200, year_published: 2002, book_cover_url: "book_cover_url_2")

      @book_3 = Book.create(title: "Title_3", number_of_pages: 300, year_published: 2003, book_cover_url: "book_cover_url_3")

      @book_4 = Book.create(title: "Title_4", number_of_pages: 400, year_published: 2004, book_cover_url: "book_cover_url_4")

      @book_5 = Book.create(title: "Title_5", number_of_pages: 500, year_published: 2005, book_cover_url: "book_cover_url_5")

      @book_6 = Book.create(title: "Title_6", number_of_pages: 600, year_published: 2006, book_cover_url: "book_cover_url_6")

      @author_2 = @book_2.authors.create(name: "John Steinbeck")
      @author_2 = @book_2.authors.create(name: "Other Guy")

      @review_1 = @book_1.reviews.create(title: 'title_1', rating: 2, text: 'body_1', username: 'user_1')
      @review_2 = @book_1.reviews.create(title: 'title_2', rating: 4, text: 'body_2', username: 'user_1')
      @review_3 = @book_1.reviews.create(title: 'title_3', rating: 2, text: 'body_3', username: 'user_2')
      @review_4 = @book_1.reviews.create(title: 'title_4', rating: 4, text: 'body_4', username: 'user_2')

      @review_5 = @book_2.reviews.create(title: 'title_5', rating: 1, text: 'body_5', username: 'user_1')
      @review_6 = @book_2.reviews.create(title: 'title_6', rating: 2, text: 'body_6', username: 'user_1')
      @review_7 = @book_2.reviews.create(title: 'title_7', rating: 1, text: 'body_7', username: 'user_2')
    end

    it 'displays top three highest rated books' do
      #VISIT PAGE
      #look at statistics
      #verify three highest rated books

    end
  end
end
