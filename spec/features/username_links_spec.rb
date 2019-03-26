require 'rails_helper'


RSpec.describe 'username links' do
  context 'as a visitor' do
    describe 'lead to users show page' do

      before :each do
        @book_1 = Book.create!(title: "Wheadas", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
        @author_1 = @book_1.authors.create(name: "Dia Owens")
        @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1', username: 'user_1')
        @review_2 = @book_1.reviews.create(title: 'title_2', rating: 4, text: 'body_2', username: 'user_1')
        @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3', username: 'user_1')
        @review_4 = @book_1.reviews.create(title: 'title_4', rating: 3, text: 'body_4', username: 'user_1')
      end

      it 'can click on link to lead to show page' do

        visit book_path(@book_1)

        within ".review-description" do
          within("#review-description-#{@review_1.id}") do
            click_link "User 1"

            expect(current_path).to eq(user_path('User 1'))
          end
        end

        visit book_path(@book_1)

        within("#statistics") do
          within ".book-review-statistics-top" do
            within("#statistics-top-#{@review_2.id}") do
              click_link "User 1"

              expect(current_path).to eq(user_path('User 1'))
            end
          end
        end

        visit book_path(@book_1)

        within("#statistics-bottom-#{@review_3.id}") do
          click_link "User 1"

          expect(current_path).to eq(user_path('User 1'))
        end
      end
    end
  end
end
