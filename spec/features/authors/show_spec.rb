require 'rails_helper'

RSpec.describe 'Author Show Page' do
  context 'as a visitor' do
    it 'shows all of the authors books' do

      book_1 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")
      book_2 = Book.create(title: "Cannery Row", number_of_pages: 208, year_published: 1945, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/41sK2DL-t7L._SX290_BO1,204,203,200_.jpg")
      book_3 = Book.create(title: "The Grapes of Wrath", number_of_pages: 464, year_published: 1939, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/51zdzn8cO3L._SX323_BO1,204,203,200_.jpg")
      book_4 = Book.create(title: "Of Mice and Men", number_of_pages: 112, year_published: 1937, book_cover_url: "https://images-na.ssl-images-amazon.com/images/I/41uqpdzU9hL._SX281_BO1,204,203,200_.jpg")
      author_1 = book_1.authors.create(name: "John Steinbeck")
      author_1 = book_2.authors.create(name: "John Steinbeck")
      author_1 = book_3.authors.create(name: "John Steinbeck")
      author_1 = book_4.authors.create(name: "John Steinbeck")
      
      visit 'author_path(:author)'

      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      author_1 = book_1.authors.create(name: "John Steinbeck")





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
