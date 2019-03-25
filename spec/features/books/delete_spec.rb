require 'rails_helper'

RSpec.describe 'Delete book workflow' do
  context 'as a visitor' do
    it 'deletes book correctly' do
      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      author_1 = book_1.authors.create(name: "Delia Owens")
      review_1 = book_1.reviews.create(title: "This book is terrible", username: "frank55", rating: 1, text: "Boots")

      visit book_path(book_1)

      click_on 'delete_book'

      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(book_1.title)
      expect(page).to_not have_content(book_1.number_of_pages)
      expect(page).to_not have_content(book_1.year_published)
      expect(page).to_not have_content(book_1.book_cover_url)
    end
  end
end


# As a Visitor,
# When I visit a book's show page,
# I see a link on the page to delete the book.
# This link should return me to the book index page where I
# no longer see this book listed.
#
# (your controller may need to delete other content before you can delete the book)
