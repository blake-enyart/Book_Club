require "rails_helper"

RSpec.describe "user_index", type: :feature do
  it "user_can_see_all_books" do
    book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
    book_2 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")

    visit "/books"

    within ".main" do
      expect(page).to have_content(book_1.title)
      expect(page).to have_content("Number of Pages: #{book_1.number_of_pages}")
      expect(page).to have_content(book_2.title)
      expect(page).to have_content("Number of Pages: #{book_2.number_of_pages}")
    end
  end
end
