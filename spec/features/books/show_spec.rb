require "rails_helper"

RSpec.describe "book show workflow", type: :feature do
  context 'as a visitor' do
    it "displays book correctly" do
      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      author_1 = book_1.authors.create(name: "Delia Owens")
      review_1 = book_1.reviews.create(title: "This book is terrible", username: "frank55", rating: 1, text: "Boots")

      visit book_path(book_1)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content("Author(s): Delia Owens")
      expect(page).to have_content("Number of Pages: #{book_1.number_of_pages}")
      expect(page).to have_content("Year Published: #{book_1.year_published}")
      expect(page).to have_link("Delia Owens")

      within ".book-review-description" do
        expect(page).to have_content("Title: #{review_1.title}")
        expect(page).to have_content("Username: #{review_1.username}")
        expect(page).to have_content("Rating: #{review_1.rating}")
        expect(page).to have_content("Description: #{review_1.text}")
      end
    end

    it "displays book review statistics" do

      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      review_1 = book_1.reviews.create(title: "This book is terrible", username: "frank55", rating: 1, text: "Boots")
      review_2 = book_1.reviews.create(title: "What a delightfully dreary book", username: "mums58", rating: 3, text: "It was just dreary.")
      review_3 = book_1.reviews.create(title: "Something to read for sure", username: "llamamama4", rating: 4, text: "I'm super happey about this book.")
      review_4 = book_1.reviews.create(title: "FOR THE LOVE OF GOD", username: "banquet1", rating: 2, text: "FOR THE LOVE OF GOD")
      review_5 = book_1.reviews.create(title: "OK", username: "matey1", rating: 3, text: "OK")

      visit book_path(book_1)

      within '.book-review-statistics-top' do
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_3.title)
        expect(page).to have_content(review_5.title)
        expect(page).not_to have_content(review_1.title)
        expect(page).not_to have_content(review_4.title)
      end

      within('#average_book_review') do
          expect(page).to have_content(book_1.average_review)
      end
    end
  end
end
