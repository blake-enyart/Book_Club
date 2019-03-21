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
# I see the following book information:
# - the book title
# - the author(s) who wrote the book
# - the number of pages in the book
# - the year the book was published
# - a large image of the book cover
#
# I also see a list of reviews for that book.
# Each review will have a title and user, a numeric rating
# from 1 to 5, and text for the review itself, and all content
# must be present for each review.
