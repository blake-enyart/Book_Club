require 'rails_helper'

RSpec.describe 'Author Show Page' type: :feature do
  context 'as a visitor' do
    describe 'primary content on authors show page' do
      before :each do


        @book_1 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")
        @book_2 = Book.create(title: "Cannery Row", number_of_pages: 208, year_published: 1945, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/41sK2DL-t7L._SX290_BO1,204,203,200_.jpg")
        @book_3 = Book.create(title: "The Grapes of Wrath", number_of_pages: 464, year_published: 1939, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/51zdzn8cO3L._SX323_BO1,204,203,200_.jpg")
        # @book_4 = Book.create(title: "Of Mice and Men", number_of_pages: 112, year_published: 1937, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/41uqpdzU9hL._SX281_BO1,204,203,200_.jpg")
        @author_1 = @book_1.authors.create(name: "John Steinbeck")
        @author_1 = @book_2.authors.create(name: "John Steinbeck")
        # @author_1 = @book_3.authors.create(name: "John Steinbeck")
        @author_1 = @book_4.authors.create(name: "John Steinbeck")

      end

      it 'displays all books correctly' do
      visit author_path(:author)

        within "#book-card-#{@book_1.id}" do
          expect(page).to have_link(@book_1.title)
          expect(page).to have_content("Number of Pages: #{@book_1.number_of_pages}")
          expect(page).to have_content("Author(s): John Steinbeck")
          expect(page).to have_link("John Steinbeck")
          expect(page).to have_content("Year Published: #{@book_1.year_published}")
          expect(page).to have_xpath("//img[@src='#{@book_1.book_cover_url}']")
          expect(page).to have_content("Average Book Rating: #{@book_1.average_review}")
          expect(page).to have_content("Total Reviews: #{@book_1.reviews.count}")
        end

        within "#book-card-#{@book_2.id}" do
          expect(page).to have_link(@book_2.title)
          expect(page).to have_content("Number of Pages: #{@book_2.number_of_pages}")
          expect(page).to have_content("Author(s): John Steinbeck Other Guy")
          expect(page).to have_link("John Steinbeck")
          expect(page).to have_link("Other Guy")
          expect(page).to have_content("Year Published: #{@book_2.year_published}")
          expect(page).to have_xpath("//img[@src='#{@book_2.book_cover_url}']")
          expect(page).to have_content("Average Book Rating: #{@book_2.average_review}")
          expect(page).to have_content("Total Reviews: #{@book_2.reviews.count}")
        end

        within "#book-card-#{@book_3.id}" do
          expect(page).to have_link(@book_3.title)
          expect(page).to have_content("Number of Pages: #{@book_3.number_of_pages}")
          expect(page).to have_content("Author(s): John Steinbeck Other Guy")
          expect(page).to have_link("John Steinbeck")
          expect(page).to have_link("Other Guy")
          expect(page).to have_content("Year Published: #{@book_3.year_published}")
          expect(page).to have_xpath("//img[@src='#{@book_3.book_cover_url}']")
          expect(page).to have_content("Average Book Rating: #{@book_3.average_review}")
          expect(page).to have_content("Total Reviews: #{@book_3.reviews.count}")
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
