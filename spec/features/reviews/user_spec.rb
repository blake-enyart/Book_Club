require 'rails_helper'

RSpec.describe "user sees book index page", type: :feature do
  describe 'user visits /books' do
    describe 'user clicks reviewer name' do
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
        @review_2 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2', username: 'user_1')
        @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3', username: 'user_2')
        @review_4 = @book_1.reviews.create(title: 'title_4', rating: 3, text: 'body_4', username: 'user_2')

        @review_5 = @book_2.reviews.create(title: 'title_5', rating: 5, text: 'body_5', username: 'user_1')
        @review_6 = @book_2.reviews.create(title: 'title_6', rating: 4, text: 'body_6', username: 'user_1')
        @review_7 = @book_2.reviews.create(title: 'title_7', rating: 3, text: 'body_7', username: 'user_2')
        @review_8 = @book_2.reviews.create(title: 'title_8', rating: 3, text: 'body_8', username: 'user_2')

        @review_9 = @book_3.reviews.create(title: 'title_8', rating: 5, text: 'body_8', username: 'user_3')

        @review_10 = @book_4.reviews.create(title: 'title_10', rating: 1, text: 'body_10', username: 'user_4')
        @review_11 = @book_4.reviews.create(title: 'title_11', rating: 1, text: 'body_11', username: 'user_4')
      end

      it 'sees all reviews' do
        visit books_path

        within("#top-reviewers-ctn") do
          click_link("User 1")
        end

        expect(current_path).to eq(user_path('User 1'))

        within("#main") do
          within("#review-card-#{@review_1.id}") do
            expect(page).to have_content('Title: title_1')
            expect(page).to have_content('Description: body_1')
            expect(page).to have_content("Rating: #{@review_1.rating}")
            expect(page).to have_content("Book: #{@review_1.book.title}")
            expect(page).to have_content("Created At: #{@review_1.created_at}")
          end

          within("#review-card-#{@review_2.id}") do
            expect(page).to have_content("Title: #{@review_2.title}")
            expect(page).to have_content("Description: #{@review_2.text}")
            expect(page).to have_content("Rating: #{@review_2.rating}")
            expect(page).to have_content("Book: #{@review_2.book.title}")
            expect(page).to have_content("Created At: #{@review_2.created_at}")
          end

          expect(page).not_to have_content('Title: title_3')
          expect(page).not_to have_content('Description: body_3')
        end
      end

      it 'deletes a review' do
        visit books_path

        within("#top-reviewers-ctn") do
          click_link("User 1")
        end

        expect(current_path).to eq(user_path('User 1'))
        expect(page).to have_css("#review-card-#{@review_1.id}")

        within("#review-card-#{@review_1.id}") do
          click_link("Delete Review")
        end

        expect(current_path).to eq(user_path('User 1'))

        expect(page).not_to have_css("#review-card-#{@review_1.id}")
      end

      it 'deletes last review by user' do
        visit books_path

        within("#top-reviewers-ctn") do
          click_link("User 4")
        end

        expect(current_path).to eq(user_path('User 4'))
        expect(page).to have_css("#review-card-#{@review_10.id}")

        within("#review-card-#{@review_10.id}") do
          click_link("Delete Review")
        end

        expect(current_path).to eq(user_path('User 4'))

        expect(page).not_to have_css("#review-card-#{@review_10.id}")
        expect(page).to have_content("User 4")

        within("#review-card-#{@review_11.id}") do
          click_link("Delete Review")
        end

        expect(current_path).to eq(user_path('User 4'))

        expect(page).not_to have_css("#review-card-#{@review_11.id}")
        expect(page).to have_content("No reviews for this user")
        expect(page).to have_content("User 4")
      end

      it 'orders reviews newest first' do
        visit books_path

        within("#top-reviewers-ctn") do
          click_link("User 4")
        end

        click_link("Newest First")

        expect(page.body.index("review-card-#{@review_10.id}")).to be >
          page.body.index("review-card-#{@review_11.id}")
      end

      it 'orders reviews oldest first' do
        visit books_path

        within("#top-reviewers-ctn") do
          click_link("User 4")
        end

        click_link("Oldest First")

        expect(page.body.index("review-card-#{@review_11.id}")).to be >
          page.body.index("review-card-#{@review_10.id}")
      end
    end
  end
end
