require 'rails_helper'

RSpec.describe 'Author Show Page', type: :feature do
  context 'as a visitor' do
    describe 'primary content on authors show page' do
      before :each do
        @author_1 = Author.create(name: "John Steinbeck")
        @book_1 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")
        @book_2 = Book.create(title: "Cannery Row", number_of_pages: 208, year_published: 1945, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/41sK2DL-t7L._SX290_BO1,204,203,200_.jpg")
        @book_3 = Book.create(title: "The Grapes of Wrath", number_of_pages: 464, year_published: 1939, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/51zdzn8cO3L._SX323_BO1,204,203,200_.jpg")
        @book_1.authors << @author_1
        @book_2.authors << @author_1
        @book_3.authors << @author_1
      end

      it 'displays all books correctly' do
      visit author_path(@author_1)

        within "#book-card-#{@book_1.id}" do
          expect(page).to have_link(@book_1.title)
          expect(page).to have_content("Number of Pages: #{@book_1.number_of_pages}")
          expect(page).to have_content("Year Published: #{@book_1.year_published}")
          expect(page).to have_xpath("//img[@src='#{@book_1.book_cover_url}']")
        end

        within "#book-card-#{@book_2.id}" do
          expect(page).to have_link(@book_2.title)
          expect(page).to have_content("Number of Pages: #{@book_2.number_of_pages}")
          expect(page).to have_content("Year Published: #{@book_2.year_published}")
          expect(page).to have_xpath("//img[@src='#{@book_2.book_cover_url}']")
        end

        within "#book-card-#{@book_3.id}" do
          expect(page).to have_link(@book_3.title)
          expect(page).to have_content("Number of Pages: #{@book_3.number_of_pages}")
          expect(page).to have_content("Year Published: #{@book_3.year_published}")
          expect(page).to have_xpath("//img[@src='#{@book_3.book_cover_url}']")
        end
      end
    end
  end
end
RSpec.describe 'Author Show Page', type: :feature do
  context 'as a visitor' do
    describe 'I see Authors Top Review' do

      before :each do
        @book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
        @book_2 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")
        @book_3 = Book.create(title: "Book_3", number_of_pages: 300, year_published: 3, book_cover_url: "image_3")
        @book_4 = Book.create(title: "Book_4", number_of_pages: 400, year_published: 4, book_cover_url: "image_4")

        @author_1 = @book_1.authors.create(name: "Delia Owens")
        @author_2 = @book_2.authors.create(name: "John Steinbeck")
        @author_2 = @book_2.authors.create(name: "Other Guy")
        @book_3.authors = [@author_1]
        @book_4.authors = [@author_1, @author_2]

        @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1', username: 'user_1')
        @review_2 = @book_1.reviews.create(title: 'title_2', rating: 4, text: 'body_2', username: 'user_1')
        @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3', username: 'user_2')
        @review_4 = @book_1.reviews.create(title: 'title_4', rating: 3, text: 'body_4', username: 'user_2')

        @review_5 = @book_2.reviews.create(title: 'title_5', rating: 5, text: 'body_5', username: 'user_1')
        @review_6 = @book_2.reviews.create(title: 'title_6', rating: 4, text: 'body_6', username: 'user_1')
        @review_7 = @book_2.reviews.create(title: 'title_7', rating: 3, text: 'body_7', username: 'user_2')
        @review_8 = @book_2.reviews.create(title: 'title_8', rating: 3, text: 'body_8', username: 'user_2')

      end

      it 'Will show one top review' do
      visit author_path(@author_1)

        within "#book-card-#{@book_1.id}" do
          expect(page).to have_content("title: #{@book_1.top_review.title}")
          expect(page).to have_content("Score: #{@book_1.top_review.rating}")
          expect(page).to have_xpath("Username: #{@book_1.top_review.username}']")
        end

        within "#book-card-#{@book_2.id}" do
          expect(page).to have_content("title: #{@book_2.top_review.title}")
          expect(page).to have_content("Score: #{@book_2.top_review.rating}")
          expect(page).to have_xpath("Username: #{@book_2.top_review.username}']")
        end
      end
    end
  end
end


# As a Visitor,
# When I visit an author's show page
# I see all books by that author
# Each book should show:
# - the book title
# - the number of pages in the book
# - the year the book was published
# - a small image of the book cover
#
# Each book should show a list of any other authors
# (exclude this show page's author from that list)
