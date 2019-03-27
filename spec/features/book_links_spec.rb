require 'rails_helper'

RSpec.describe 'Book links' do
  context 'as a visitor' do
    describe 'Clicking book links lead to Books show page' do

      before :each do
        @book_1 = Book.create!(title: "Wheadas", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
        @author_1 = @book_1.authors.create(name: "Dia Owens")
        @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1', username: 'user_1')
        @review_2 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2', username: 'user_1')
        @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3', username: 'user_2')
        @review_4 = @book_1.reviews.create(title: 'title_4', rating: 3, text: 'body_4', username: 'user_2')
      end

      it 'can click on an Book name anywhere and link to the show page' do

        visit books_path

        within '.book-ctn' do
          click_link "Wheadas"

          expect(current_path).to eq(book_path(@book_1))
        end

        visit books_path

        within('#btm-book-ctn') do
          click_link "Wheadas"

          expect(current_path).to eq(book_path(@book_1))
        end

        visit books_path

        within('#top-book-ctn') do
          click_link "Wheadas"

          expect(current_path).to eq(book_path(@book_1))
        end


        visit author_path(@author_1)

        within('.main') do
          click_link "Wheadas"

          expect(current_path).to eq(book_path(@book_1))
        end
      end
    end
  end
end

# As a visitor
# With the exception of an author's show page,
# Anywhere I see an author's name on the site,
# I can click on the name to go to that author's show page.
