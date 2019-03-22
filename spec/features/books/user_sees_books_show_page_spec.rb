require "rails_helper"

RSpec.describe "user sees all books", type: :feature do
  describe 'user visits /books/1' do
    it "displays book correctly" do
      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      author_1 = book_1.authors.create(name: "Delia Owens")
      review_1 = book_1.reviews.create(title: "This book is terrible", username: "frank55", rating: 1, text: "Boots")


      visit book_path(book_1)

        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Author(s): Delia Owens")
        expect(page).to have_content("Number of Pages: #{book_1.number_of_pages}")
        expect(page).to have_content("Year Published: #{book_1.year_published}")
        expect(page).to have_content("Delia Owens")
        expect(page).to have_content("Title: #{book_1.reviews[0].title}")
        expect(page).to have_content("Username: #{book_1.reviews[0].username}")
        expect(page).to have_content("Rating: #{book_1.reviews[0].rating}")
        expect(page).to have_content("Description:")

      within '.book-review-card' do
        expect(page).to have_content("#{book_1.reviews[0].text}")
      end
    end
  end

  describe 'user visits /books/1' do
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
      end

      within '.book-review-statistics-top' do
        expect(page).not_to have_content(review_1.title)
        expect(page).not_to have_content(review_4.title)
      end
    end
  end

  describe 'user visits /books/1' do
    it "displays book review statistics" do


      book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      review_1 = book_1.reviews.create(title: "This book is terrible", username: "frank55", rating: 1, text: "Boots")

      visit book_path(book_1)

      within '.book-review-statistics-top' do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.username)
      end
    end
  end
end

# create_table "reviews", force: :cascade do |t|
#   t.string "title"
#   t.integer "rating"
#   t.string "text"
#   t.string "username"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.bigint "book_id"
#   t.index ["book_id"], name: "index_reviews_on_book_id"
# end
# As a Visitor,
# When I visit a book's show page,
# I see an area on the page for statistics about reviews:
# - the top three reviews for this book (title, rating and user only)
# - the bottom three reviews for this book  (title, rating and user only)
# - the overall average rating of all reviews for this book
