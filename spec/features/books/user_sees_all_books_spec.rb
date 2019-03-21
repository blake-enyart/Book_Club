require "rails_helper"

RSpec.describe "user sees all books", type: :feature do
  describe 'user visits /books' do
    it "displays all books" do
      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      book_2 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")

      author_1 = book_1.authors.create(name: "Delia Owens")
      author_2 = book_2.authors.create(name: "John Steinbeck")

      visit books_path

      within "\##{book_1.id}" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Number of Pages: #{book_1.number_of_pages}")
        expect(page).to have_content("Author(s): Delia Owens")
        expect(page).to have_content("Year Published: #{book_1.year_published}")
      end

      within "\##{book_2.id}" do
        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Number of Pages: #{book_2.number_of_pages}")
        expect(page).to have_content("Author(s): John Steinbeck")
        expect(page).to have_content("Year Published: #{book_2.year_published}")
      end
    end
  end
end
